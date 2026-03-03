extends CanvasLayer

var is_engaged: bool = true
var rc_mode: bool = false:
	set(val):
		if rc_mode == val: return
		rc_mode = val
		show_arrows()
		if rc_mode:
			InputMap.action_erase_event("ui_left", create_axis(JOY_AXIS_RIGHT_X, -1))
			InputMap.action_erase_event("ui_right", create_axis(JOY_AXIS_RIGHT_X, 1))
			InputMap.action_erase_event("ui_up", create_axis(JOY_AXIS_LEFT_Y, -1))
			InputMap.action_erase_event("ui_down", create_axis(JOY_AXIS_LEFT_Y, 1))
		else:
			InputMap.load_from_project_settings()

var stickRadius = 32.0
var leftThumb = {
		id = 0,
		center = Vector2.ZERO,
		dir = Vector2.ZERO,
		btn = false
	}
var rightThumb = {
		id = 0,
		center = Vector2.ZERO,
		dir = Vector2.ZERO,
		btn = false
	}

var axes = { }
var strengths = { }


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	show_arrows()
	leftThumb.center = %LeftSlider.global_position
	rightThumb.center = %RightSlider.global_position
	disengage()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Fire.modulate.a = 1 if Input.is_action_pressed("ui_accept") else 0.25
	%Dpad/LeftBtn.modulate.a = 1 if Input.is_action_pressed("ui_left") else 0.25
	%Dpad/RightBtn.modulate.a = 1 if Input.is_action_pressed("ui_right") else 0.25
	%Dpad/UpBtn.modulate.a = 1 if Input.is_action_pressed("ui_up") else 0.25
	%Dpad/DownBtn.modulate.a = 1 if Input.is_action_pressed("ui_down") else 0.25
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down", 0)
	%LeftSlider/Knob.position = dir * stickRadius
	%RightSlider/Knob.position = dir * stickRadius
	if rc_mode:
		%LeftSlider/Knob.position.y = 0
		%RightSlider/Knob.position.x = 0


func _input(event: InputEvent) -> void:
	if not is_engaged: return
	if not event is InputEventFromWindow: return
	if event is InputEventMouse: return
	#if event is InputEventMouseButton:
	if event is InputEventScreenTouch:
		show()
		if event.position.x < get_viewport().get_visible_rect().size.x / 2:
			leftThumb.id += 1
			leftThumb.center = event.position
			leftThumb.dir = Vector2.ZERO
			leftThumb.btn = event.pressed
		else:
			rightThumb.id += 1
			rightThumb.center = event.position
			rightThumb.dir = Vector2.ZERO
			fire(rightThumb.btn)
			rightThumb.btn = event.pressed
	#if event is InputEventMouseMotion:
	if event is InputEventScreenDrag:
		var thumb
		if event.position.x < get_viewport().get_visible_rect().size.x / 2:
			thumb = leftThumb
		else:
			thumb = rightThumb
		thumb.dir = (event.position - thumb.center) / stickRadius
		if thumb.dir.length() > 1 / 3:
			thumb.btn = false
		if thumb.dir.length() > 1:
			thumb.dir = thumb.dir.normalized()
			thumb.center = event.position - thumb.dir * stickRadius
	var dir = Vector2.ZERO
	if rc_mode:
		dir.x = leftThumb.dir.x
		dir.y = rightThumb.dir.y
	else:
		dir = leftThumb.dir + rightThumb.dir
	if dir.length() > 1: dir = dir.normalized()
	send_axis(JOY_AXIS_LEFT_X, leftThumb.dir.x)
	send_axis(JOY_AXIS_LEFT_Y, leftThumb.dir.y)
	send_axis(JOY_AXIS_RIGHT_X, rightThumb.dir.x)
	send_axis(JOY_AXIS_RIGHT_Y, rightThumb.dir.y)
	#for action in ["ui_left", "ui_right", "ui_up", "ui_down"]:
		#var strength = 0.0
		#match action:
			#"ui_left": strength = -clamp(dir.x, -1, 0)
			#"ui_right": strength = clamp(dir.x, 0, 1)
			#"ui_up": strength = -clamp(dir.y, -1, 0)
			#"ui_down": strength = clamp(dir.y, 0, 1)
		#send_action(action, strength)
	%LeftSlider.global_position = leftThumb.center + Vector2(32, -32)
	%RightSlider.global_position = rightThumb.center + Vector2(-32, -32)
	%Fire.global_position = rightThumb.center + Vector2(0, -64)


func fire(down = true):
	send_action("ui_accept", down)
	alt()
	if not down: return
	await get_tree().create_timer(0.5).timeout
	send_action("ui_accept", false)


func alt():
	var id = rightThumb.id
	send_action("ui_select", false)
	await get_tree().create_timer(0.5).timeout
	if id != rightThumb.id: return
	send_action("ui_select", rightThumb.btn)
	if not rightThumb.btn: return
	await get_tree().create_timer(0.25).timeout
	send_action("ui_select", false)


func send_action(action, strength):
	if strength is bool:
		strength = 1.0 if strength else 0.0
	if not(action in strengths): strengths[action] = -1
	if strengths[action] == strength: return
	strengths[action] = strength
	#print(action, ": ", strength)
	var e = InputEventAction.new()
	e.action = action
	e.strength = strength
	e.pressed = strength > 0.5
	Input.parse_input_event(e)


func send_axis(axis: JoyAxis, value: float):
	if not(axis in axes): axes[axis] = -2
	if axes[axis] == value: return
	axes[axis] = value
	var e = InputEventJoypadMotion.new()
	e.axis = axis
	e.axis_value = value
	Input.parse_input_event(e)


func engage(rc: bool = rc_mode) -> void:
	rc_mode = rc
	if is_engaged: return
	ProjectSettings.set_setting("input_devices/pointing/emulate_mouse_from_touch", false)
	#leftThumb.center = %LeftSlider.global_position - Vector2(32, -32)
	#rightThumb.center = %RightSlider.global_position - Vector2(-32, -32)
	%AnimationPlayer.play("engage")
	create_tween().tween_property(%LeftSlider, "position", Vector2.ZERO, 1)
	create_tween().tween_property(%RightSlider, "position", Vector2.ZERO, 1)
	create_tween().tween_property(%Fire, "position", Vector2(32, -32), 1)
	set_deferred("is_engaged", true)
	show_arrows()


func disengage() -> void:
	if not is_engaged: return
	is_engaged = false
	rc_mode = not rc_mode
	ProjectSettings.set_setting("input_devices/pointing/emulate_mouse_from_touch", true)
	leftThumb.center -= %LeftSlider.position
	rightThumb.center -= %RightSlider.position
	leftThumb.dir = Vector2.ZERO
	rightThumb.dir = Vector2.ZERO
	leftThumb.btn = false
	rightThumb.btn = false
	for axis in [JOY_AXIS_LEFT_X, JOY_AXIS_LEFT_Y, JOY_AXIS_RIGHT_X, JOY_AXIS_RIGHT_Y]:
		send_axis(axis, 0.0)
	for action in ["ui_left", "ui_right", "ui_up", "ui_down", "ui_accept", "ui_select"]:
		send_action(action, false)
	%AnimationPlayer.play("disengage")
	create_tween().tween_property(%LeftSlider, "position", Vector2(110, -190), 1)
	create_tween().tween_property(%RightSlider, "position", Vector2(-110, -190), 1)
	create_tween().tween_property(%Fire, "position", Vector2(-142, -222), 1)
	hide()


func show_arrows():
	%LeftSlider/Knob/Arrows.hide()
	%LeftSlider/Knob/HArrows.hide()
	%RightSlider/Knob/Arrows.hide()
	%RightSlider/Knob/VArrows.hide()
	if rc_mode:
		%LeftSlider/Knob/HArrows.show()
		%RightSlider/Knob/VArrows.show()
	else:
		%LeftSlider/Knob/Arrows.show()
		%RightSlider/Knob/Arrows.show()


func create_axis(axis: JoyAxis, value: float):
	var e = InputEventJoypadMotion.new()
	e.axis = axis
	e.axis_value = value
	return e
