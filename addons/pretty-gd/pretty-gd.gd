@tool
extends EditorPlugin

var enabled
var timer

var _last_row = 0


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	print("entering pretty.gd pluging")
	resource_saved.connect(_on_resource_saved)
	timer = Timer.new()
	get_tree().root.add_child(timer)
	timer.timeout.connect(_on_tick)
	timer.start()
	enabled = true


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	print("exiting pretty.gd pluging")
	resource_saved.disconnect(_on_resource_saved)
	timer.queue_free()
	enabled = false


func _on_resource_saved(res: Resource):
	if res.resource_path.ends_with(".gd"):
		await get_tree().create_timer(1).timeout
		var dirty = FileAccess.get_file_as_string(res.resource_path)
		var pretty = Prettifier.prettify(dirty) + "\n"
		if pretty and dirty != pretty:
			print("pretty.gd: ", res.resource_path, " 🎀")
			var file = FileAccess.open(res.resource_path, FileAccess.WRITE)
			file.store_string(pretty)
			file.close()


func _on_tick():
	var editor = EditorInterface.get_script_editor().get_current_editor()
	if editor:
		var ed = editor.get_base_editor()
		var row = ed.get_caret_line()
		if abs(_last_row - row) > 1:
			var dirty = ed.text
			var pretty = Prettifier.prettify(dirty) + "\n"
			if pretty and dirty != pretty:
				var lines = pretty.split("\n")
				while ed.get_line_count() < lines.size():
					ed.insert_line_at(ed.get_line_count() - 1, "")
				for line_num in range(ed.get_line_count()):
					while lines[line_num] and not ed.get_line(line_num):
						ed.remove_line_at(line_num)
						ed.insert_line_at(ed.get_line_count() - 1, "#")
					if ed.get_line(line_num) and not lines[line_num]:
						ed.insert_line_at(line_num, "")
					#if line_num == row: continue
					if line_num < lines.size():
						ed.set_line(line_num, lines[line_num])
					else:
						ed.set_line(line_num, "")
			_last_row = row
