extends Node2D

var Prettifier = preload("res://addons/pretty-gd/pretty.gd").new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://addons/pretty-gd/README.md", FileAccess.WRITE)
	file.store_string(FileAccess.get_file_as_string("res://README.md"))
	file.close()
	file = FileAccess.open("res://addons/pretty-gd/LICENSE", FileAccess.WRITE)
	file.store_string(FileAccess.get_file_as_string("res://LICENSE"))
	file.close()

	print(Prettifier.prettify(FileAccess.get_file_as_string("res://addons/pretty-gd/pretty.gd")))
	var ascii = ""
	for i in range(32, 127):
		ascii += "".chr(i)
	print(ascii)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
