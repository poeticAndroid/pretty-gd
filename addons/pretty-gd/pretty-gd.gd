@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	resource_saved.connect(_on_resource_saved)
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	resource_saved.disconnect(_on_resource_saved)
	pass






func _on_resource_saved(res:Resource):
	print("_on_resource_saved: ",res.resource_path)
	if res.resource_path.ends_with(".gd"):
		var dirty=FileAccess.get_file_as_string(res.resource_path)
		var pretty=Prettifier.prettify(dirty)
		if dirty!=pretty:
			var file=FileAccess.open(res.resource_path,FileAccess.WRITE)
			file.store_string(pretty)
			file.close()
	
	
	
	
	
	
	
	
