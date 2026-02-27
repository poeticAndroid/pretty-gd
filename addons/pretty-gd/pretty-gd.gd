@tool
extends EditorPlugin

var timer
var unsaved

var _last_modified = 0
var _changed_scripts = []


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	EditorInterface.get_script_editor().editor_script_changed.connect(_on_editor_script_changed)
	scene_saved.connect(_on_scene_saved)
	timer = Timer.new()
	get_tree().root.add_child(timer)
	timer.timeout.connect(_on_tick)
	timer.start()
	print("pretty.gd enabled 🎀")


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	EditorInterface.get_script_editor().editor_script_changed.disconnect(_on_editor_script_changed)
	scene_saved.disconnect(_on_scene_saved)
	if timer: timer.queue_free()
	print("pretty.gd disabled 💩")


func _on_editor_script_changed(script):
	if _changed_scripts.has(script.resource_path):
		_changed_scripts.erase(script.resource_path)
		pretty_editor()


func _on_scene_saved(path: String):
	unsaved = true


func _on_tick():
	if not unsaved: return
	unsaved = false

	if pretty_editor():
		EditorInterface.save_scene()
		var script = EditorInterface.get_script_editor().get_current_script()
		if not script: return false
		print("pretty.gd: ", script.resource_path, " 🎀")
	else:
		pretty_dir()


func pretty_editor():
	var script = EditorInterface.get_script_editor().get_current_script()
	if not script: return false
	if not script.resource_path.ends_with(".gd"): return false
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
	var files = DirAccess.get_files_at(path)
	for file in files:
		pretty_file(path + file, since)
	var dirs = DirAccess.get_directories_at(path)
	for dir in dirs:
		pretty_dir(path + dir + "/", since)


func pretty_file(path, since = 0):
	if not path.ends_with(".gd"): return
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
	if not _changed_scripts.has(path):
		_changed_scripts.push_back(path)
	return true
