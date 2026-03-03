@tool
extends EditorPlugin

var included_paths = ["res://"]
var excluded_paths = ["res://addons/"]
var is_enabled_pretty_focus = true
var is_enabled_pretty_editor = true
var is_enabled_pretty_dir = true

var timer
var unsaved

var _last_modified = 0
#var _changed_scripts = []

const SETTINGS_PATH = "pretty-gd/"
var Prettifier = preload("res://addons/pretty-gd/pretty.gd").new()


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	_on_settings_changed()
	EditorInterface.get_editor_settings().settings_changed.connect(_on_settings_changed)
	EditorInterface.get_script_editor().editor_script_changed.connect(_on_editor_script_changed)
	get_window().focus_entered.connect(_on_editor_script_changed)
	scene_saved.connect(_on_scene_saved)
	timer = Timer.new()
	get_tree().root.add_child(timer)
	timer.timeout.connect(_on_tick)
	timer.start()
	print("pretty.gd enabled 🎀")


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	EditorInterface.get_editor_settings().settings_changed.disconnect(_on_settings_changed)
	EditorInterface.get_script_editor().editor_script_changed.disconnect(_on_editor_script_changed)
	get_window().focus_entered.disconnect(_on_editor_script_changed)
	scene_saved.disconnect(_on_scene_saved)
	if timer: timer.queue_free()
	print("pretty.gd disabled 💩")


func _on_settings_changed():
	var settings = EditorInterface.get_editor_settings()

	if not settings.has_setting(SETTINGS_PATH + "included_paths"):
		settings.set_setting(SETTINGS_PATH + "included_paths", "\n".join(included_paths))
	settings.add_property_info({ name = SETTINGS_PATH + "included_paths", type = TYPE_STRING, hint = PROPERTY_HINT_MULTILINE_TEXT })
	if not settings.has_setting(SETTINGS_PATH + "excluded_paths"):
		settings.set_setting(SETTINGS_PATH + "excluded_paths", "\n".join(excluded_paths))
	settings.add_property_info({ name = SETTINGS_PATH + "excluded_paths", type = TYPE_STRING, hint = PROPERTY_HINT_MULTILINE_TEXT })
	if not settings.has_setting(SETTINGS_PATH + "pretty_editor_on_focus"):
		settings.set_setting(SETTINGS_PATH + "pretty_editor_on_focus", is_enabled_pretty_focus)
	if not settings.has_setting(SETTINGS_PATH + "pretty_editor_on_save"):
		settings.set_setting(SETTINGS_PATH + "pretty_editor_on_save", is_enabled_pretty_editor)
	if not settings.has_setting(SETTINGS_PATH + "pretty_filesystem_on_save"):
		settings.set_setting(SETTINGS_PATH + "pretty_filesystem_on_save", is_enabled_pretty_dir)

	included_paths = settings.get_setting(SETTINGS_PATH + "included_paths").split("\n", false)
	excluded_paths = settings.get_setting(SETTINGS_PATH + "excluded_paths").split("\n", false)
	is_enabled_pretty_focus = settings.get_setting(SETTINGS_PATH + "pretty_editor_on_focus")
	is_enabled_pretty_editor = settings.get_setting(SETTINGS_PATH + "pretty_editor_on_save")
	is_enabled_pretty_dir = settings.get_setting(SETTINGS_PATH + "pretty_filesystem_on_save")

	Prettifier.tab_size = settings.get_setting("text_editor/behavior/indent/size")
	if settings.get_setting("text_editor/behavior/indent/type"):
		Prettifier.indent_str = " ".repeat(Prettifier.tab_size)
	else:
		Prettifier.indent_str = "\t"


func _on_editor_script_changed(script = null):
	if is_enabled_pretty_focus:
		pretty_editor()


func _on_scene_saved(path: String):
	unsaved = true


func _on_tick():
	if not unsaved: return
	unsaved = false

	if is_enabled_pretty_editor and pretty_editor():
		EditorInterface.save_scene()
		var script = EditorInterface.get_script_editor().get_current_script()
		if not script: return false
		print("pretty.gd: ", script.resource_path, " 🎀")
	else:
		for included in included_paths:
			pretty_dir(included)


func pretty_editor():
	var script = EditorInterface.get_script_editor().get_current_script()
	if not script: return false
	if not is_valid_script(script.resource_path): return false
	var editor = EditorInterface.get_script_editor().get_current_editor()
	if not editor: return false

	var ed = editor.get_base_editor()
	var dirty = ed.text
	var pretty = Prettifier.prettify(dirty) + "\n"
	if not pretty: return false
	if not pretty.strip_edges(): return false
	if dirty.strip_edges() == pretty.strip_edges(): return false

	var lines = pretty.split("\n")
	for line_num in range(max(lines.size(), ed.get_line_count())):
		if line_num < lines.size():
			while lines[line_num].strip_edges() and not ed.get_line(line_num).strip_edges():
				ed.remove_line_at(line_num)
				#ed.insert_line_at(ed.get_line_count() - 1, "#")
			if ed.get_line(line_num).strip_edges() and not lines[line_num].strip_edges():
				ed.insert_line_at(line_num, "#")
			while line_num >= ed.get_line_count():
				ed.insert_line_at(ed.get_line_count() - 1, "")
			if ed.get_line(line_num) != lines[line_num]:
				ed.set_line(line_num, lines[line_num])
		else:
			if ed.get_line(line_num):
				ed.set_line(line_num, "")
	return true


func pretty_dir(path = "res://", since = _last_modified):
	if not is_enabled_pretty_dir: return false
	for excluded in excluded_paths:
		if path.begins_with(excluded): return false
	var files = DirAccess.get_files_at(path)
	for file in files:
		if not file.begins_with("."):
			pretty_file(path + file, since)
	var dirs = DirAccess.get_directories_at(path)
	for dir in dirs:
		if not dir.begins_with("."):
			pretty_dir(path + dir + "/", since)


func pretty_file(path, since = 0):
	if not is_valid_script(path): return false
	var modified = FileAccess.get_modified_time(path)
	if modified <= since: return

	var dirty = FileAccess.get_file_as_string(path)
	var pretty = Prettifier.prettify(dirty).strip_edges() + "\n"
	if not pretty: return false
	if not pretty.strip_edges(): return false
	if dirty == pretty:
		_last_modified = max(_last_modified, modified)
		return false

	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(pretty)
	file.close()
	print("pretty.gd: ", path, " 🎀")
	#if not _changed_scripts.has(path):
		#_changed_scripts.push_back(path)
	return true


func is_valid_script(path):
	if path.contains("/."): return false
	if not path.ends_with(".gd"): return false
	for excluded in excluded_paths:
		if path.begins_with(excluded): return false
	for included in included_paths:
		if path.begins_with(included): return true
	return false
