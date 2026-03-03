extends Node2D

const DESKTOP_INPUT = 0
const TOUCH_INPUT = 1
const GAMEPAD_INPUT = 2

var session: Dictionary = { }
var persistant: Dictionary = { }
var persistant_json: String

var input_method: int = -1

var loading: bool
var scene_name: String = "/start"
var history: Array = []

var music: AudioStreamPlayer


func _ready():
	$TransitionAnimations.play_backwards("fade_to_black")
	if FileAccess.file_exists("user://persistant.json"):
		persistant = JSON.parse_string(FileAccess.get_file_as_string("user://persistant.json"))
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	get_tree().get_root().go_back_requested.connect(go_back)
	get_tree().node_added.connect(_on_node_added)
	scene_name = get_tree().current_scene.scene_file_path.replace("res:/", "").replace(".tscn", "")
	history.push_back(scene_name)
	print("Current scene: ", scene_name)


func _input(event: InputEvent):
	if event.is_class("InputEventKey"):
		input_method = DESKTOP_INPUT
	if event.is_class("InputEventMouseButton"):
		input_method = DESKTOP_INPUT
	if event.is_class("InputEventScreenTouch"):
		input_method = TOUCH_INPUT
	if event.is_class("InputEventJoypadButton"):
		input_method = GAMEPAD_INPUT

	if event.is_class("InputEventMouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event.is_class("InputEventFromWindow"):
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	elif event.is_class("InputEventJoypadButton"):
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	if event.is_action_pressed("ui_cancel"):
		go_back()
	if event.is_action_pressed("toggle_fullscreen"):
		toggle_fullscreen()
	if event.is_action_pressed("toggle_music"):
		toggle_audio("Music")
	if event.is_action_pressed("toggle_sfx"):
		toggle_audio("SFX")
	if event.is_action_pressed("toggle_touch"):
		toggle_touch()


func toggle_fullscreen():
	if get_window().mode == Window.MODE_WINDOWED:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED


func toggle_audio(bus = "Master", mute = null):
	var is_mute = AudioServer.is_bus_mute(AudioServer.get_bus_index(bus))
	if mute == null: AudioServer.set_bus_mute(AudioServer.get_bus_index(bus), not is_mute)
	else: AudioServer.set_bus_mute(AudioServer.get_bus_index(bus), mute)


func play_music(m: AudioStreamPlayer):
	if not m: return
	print("music: ", m.stream)
	if music and music.stream != m.stream:
		fadeout_music()
		music = null
	if not music:
		music = m
		music.remove_from_group("music")
		music.bus = "Music"
		print("Playing on ", music.bus, " bus")
		music.reparent($".")
		music.play()


func fadeout_music():
	if not music: return
	var m = music
	var tween = create_tween()
	tween.tween_property(m, "volume_linear", 0, 1)
	await tween.finished
	m.queue_free()


func go_back(fade: bool = true):
	if loading:
		return false
	if get_tree().get_node_count_in_group("touch_controller"):
		TouchControls.disengage()
	history.pop_back()
	if history.size():
		goto_scene(history.pop_back(), fade)
	elif $ReloadTimer.is_stopped():
		$QuitTip.visible = true
		$ReloadTimer.start()
	else:
		get_tree().quit()


func reload_current_scene(fade: bool = false):
	replace_scene(scene_name, fade)


func replace_scene(name: String, fade: bool = false):
	if loading:
		return false
	history.pop_back()
	goto_scene(name, fade)


func goto_scene(name: String, fade: bool = true):
	if loading:
		return false
	loading = true
	if name.is_absolute_path():
		name = name.simplify_path()
	else:
		name = scene_name.get_base_dir().path_join(name).simplify_path()
	assert(ResourceLoader.exists("res:/" + name + ".tscn"), "Scene not found " + name)
	print("Loading scene '" + name + "'")
	scene_name = name
	history.push_back(name)

	if fade:
		$TransitionAnimations.play("fade_to_black")
		await $TransitionAnimations.animation_finished

	$QuitTip.visible = false
	get_tree().change_scene_to_file("res:/" + scene_name + ".tscn")
	await get_tree().node_added
	await get_tree().current_scene.ready

	var btn = get_tree().get_first_node_in_group("autofocus")
	if btn and btn.has_method("grab_focus"): btn.grab_focus()
	play_music(get_tree().get_first_node_in_group("music"))

	if fade:
		$TransitionAnimations.play_backwards("fade_to_black")
		await $TransitionAnimations.animation_finished

	loading = false
	print(scene_name, " loaded!")


func save_persistant():
	var file = FileAccess.open("user://persistant.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(persistant, "  "))
	file.close()


func play_sound(node: AudioStreamPlayer):
	node.reparent($".")
	node.play()
	await node.finished
	node.queue_free()


func toggle_touch():
	ProjectSettings.set_setting("input_devices/pointing/emulate_touch_from_mouse",
			not ProjectSettings.get_setting("input_devices/pointing/emulate_touch_from_mouse"))


func _on_reload_timer_timeout() -> void:
	replace_scene(scene_name, true)


func _on_save_timer_timeout() -> void:
	var json = JSON.stringify(persistant)
	if persistant_json == json: return
	persistant_json = json
	save_persistant()


func _on_node_added(node: Node) -> void:
	if "bus" in node and node.bus == "Master":
		node.bus = "SFX"
		print(node, ".bus = ", node.bus)
