extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Prettifier.prettify( FileAccess.get_file_as_string("res://addons/pretty-gd/pretty.gd") ) )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
