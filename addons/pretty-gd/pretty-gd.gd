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
	
	
	
	
	
	
	
	
	
