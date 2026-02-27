@tool
extends EditorPlugin

var enabled
var timer

var _last_modified = 0


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	print("entering pretty.gd pluging")
	scene_saved.connect(_on_scene_saved)
	#timer = Timer.new()
	#get_tree().root.add_child(timer)
	#timer.timeout.connect(_on_tick)
	#timer.start()
	enabled = true


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	print("exiting pretty.gd pluging")
	scene_saved.disconnect(_on_scene_saved)
	if timer: timer.queue_free()
	enabled = false


func _on_scene_saved(path: String):
	print("_on_scene_saved ", path)
	if pretty_editor():
		await get_tree().create_timer(1).timeout
		EditorInterface.save_scene()
		return
	pretty_dir()


func _on_tick():
	pretty_dir()


func pretty_editor():
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
	return true
