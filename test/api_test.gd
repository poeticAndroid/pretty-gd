#; setTimeout(e => { (new Node())._ready() })
extends Node

var answers = [-2, -2, -2, -2, -2, -2, -1, -1, -1, -1, -2, -1, 0, 0, 0, -2, -1, 0, 1, 1, -2, -1, 0, 1, 2, -2, -1, -1, -1, -1, -2, -1, -1, -1, -1, -2, -1, 0, 0, 0, -2, -1, 0, 1, 1, -2, -1, 0, 1, 2, -2, -1, 0, 0, 0, -2, -1, 0, 0, 0, -2, -1, 0, 0, 0, -2, -1, 0, 1, 1, -2, -1, 0, 1, 2, -2, -1, 0, 1, 1, -2, -1, 0, 1, 1, -2, -1, 0, 1, 1, -2, -1, 0, 1, 1, -2, -1, 0, 1, 2, -2, -1, 0, 1, 2, -2, -1, 0, 1, 2, -2, -1, 0, 1, 2, -2, -1, 0, 1, 2, -2, -1, 0, 1, 2, -2, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, -2, -1, -1, -1, -1, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, true, false, true, false, true, true, true, true, false, true, "", "", "", "", "", "", "", "", " Lor", "", "Lorem", "m ipsum, dolor, sit am", "", "ipsum,", "t.. ", 33, 32, -1, -1, 0, 27, -1, 32, 0, 27, -1, -1, 0, -1, -1, -1, 0, -1, -1, -1, 0, -1, "YZ[\\]^_`abcdefghijklmnopqrstuvw", "orem ipsum, dolor, sit amet.. ", "XYZ[\\]^_`abcdefghijklmnopqrstuvw", "Lorem ipsum, dolor, sit amet.. ", "", "", "w", " ", "vw", ". ", "false,-2", "[\"W\",\"X\",\"Y\",\"Z\",\"[\",\"\\\\\",\"]\",\"^\",\"_\",\"`\",\"a\",\"b\",\"c\",\"d\",\"e\",\"f\",\"g\",\"h\",\"i\",\"j\",\"k\",\"l\",\"m\",\"n\",\"o\",\"p\",\"q\",\"r\",\"s\",\"t\",\"u\",\"v\",\"w\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"o\",\"r\",\"e\",\"m\",\" \",\"i\",\"p\",\"s\",\"u\",\"m\",\",\",\" \",\"d\",\"o\",\"l\",\"o\",\"r\",\",\",\" \",\"s\",\"i\",\"t\",\" \",\"a\",\"m\",\"e\",\"t\",\".\",\".\",\" \"]", "[\"Lorem\",\"ipsum,\",\"dolor,\",\"sit\",\"amet..\"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", "true,-2", "[\"W\",\"X\",\"Y\",\"Z\",\"[\",\"\\\\\",\"]\",\"^\",\"_\",\"`\",\"a\",\"b\",\"c\",\"d\",\"e\",\"f\",\"g\",\"h\",\"i\",\"j\",\"k\",\"l\",\"m\",\"n\",\"o\",\"p\",\"q\",\"r\",\"s\",\"t\",\"u\",\"v\",\"w\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"o\",\"r\",\"e\",\"m\",\" \",\"i\",\"p\",\"s\",\"u\",\"m\",\",\",\" \",\"d\",\"o\",\"l\",\"o\",\"r\",\",\",\" \",\"s\",\"i\",\"t\",\" \",\"a\",\"m\",\"e\",\"t\",\".\",\".\",\" \"]", "[\"\",\"Lorem\",\"ipsum,\",\"dolor,\",\"sit\",\"amet..\",\"\"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", "false,-1", "[\"W\",\"X\",\"Y\",\"Z\",\"[\",\"\\\\\",\"]\",\"^\",\"_\",\"`\",\"a\",\"b\",\"c\",\"d\",\"e\",\"f\",\"g\",\"h\",\"i\",\"j\",\"k\",\"l\",\"m\",\"n\",\"o\",\"p\",\"q\",\"r\",\"s\",\"t\",\"u\",\"v\",\"w\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"o\",\"r\",\"e\",\"m\",\" \",\"i\",\"p\",\"s\",\"u\",\"m\",\",\",\" \",\"d\",\"o\",\"l\",\"o\",\"r\",\",\",\" \",\"s\",\"i\",\"t\",\" \",\"a\",\"m\",\"e\",\"t\",\".\",\".\",\" \"]", "[\"Lorem\",\"ipsum,\",\"dolor,\",\"sit\",\"amet..\"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", "true,-1", "[\"W\",\"X\",\"Y\",\"Z\",\"[\",\"\\\\\",\"]\",\"^\",\"_\",\"`\",\"a\",\"b\",\"c\",\"d\",\"e\",\"f\",\"g\",\"h\",\"i\",\"j\",\"k\",\"l\",\"m\",\"n\",\"o\",\"p\",\"q\",\"r\",\"s\",\"t\",\"u\",\"v\",\"w\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"o\",\"r\",\"e\",\"m\",\" \",\"i\",\"p\",\"s\",\"u\",\"m\",\",\",\" \",\"d\",\"o\",\"l\",\"o\",\"r\",\",\",\" \",\"s\",\"i\",\"t\",\" \",\"a\",\"m\",\"e\",\"t\",\".\",\".\",\" \"]", "[\"\",\"Lorem\",\"ipsum,\",\"dolor,\",\"sit\",\"amet..\",\"\"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", "false,0", "[\"W\",\"X\",\"Y\",\"Z\",\"[\",\"\\\\\",\"]\",\"^\",\"_\",\"`\",\"a\",\"b\",\"c\",\"d\",\"e\",\"f\",\"g\",\"h\",\"i\",\"j\",\"k\",\"l\",\"m\",\"n\",\"o\",\"p\",\"q\",\"r\",\"s\",\"t\",\"u\",\"v\",\"w\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"o\",\"r\",\"e\",\"m\",\" \",\"i\",\"p\",\"s\",\"u\",\"m\",\",\",\" \",\"d\",\"o\",\"l\",\"o\",\"r\",\",\",\" \",\"s\",\"i\",\"t\",\" \",\"a\",\"m\",\"e\",\"t\",\".\",\".\",\" \"]", "[\"Lorem\",\"ipsum,\",\"dolor,\",\"sit\",\"amet..\"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", "true,0", "[\"W\",\"X\",\"Y\",\"Z\",\"[\",\"\\\\\",\"]\",\"^\",\"_\",\"`\",\"a\",\"b\",\"c\",\"d\",\"e\",\"f\",\"g\",\"h\",\"i\",\"j\",\"k\",\"l\",\"m\",\"n\",\"o\",\"p\",\"q\",\"r\",\"s\",\"t\",\"u\",\"v\",\"w\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"o\",\"r\",\"e\",\"m\",\" \",\"i\",\"p\",\"s\",\"u\",\"m\",\",\",\" \",\"d\",\"o\",\"l\",\"o\",\"r\",\",\",\" \",\"s\",\"i\",\"t\",\" \",\"a\",\"m\",\"e\",\"t\",\".\",\".\",\" \"]", "[\"\",\"Lorem\",\"ipsum,\",\"dolor,\",\"sit\",\"amet..\",\"\"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", "false,1", "[\"W\",\"XYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"Lorem ipsum, dolor, sit amet.. \"]", "[\"Lorem\",\"ipsum, dolor, sit amet.. \"]", "[\" Lor\",\"m ipsum, dolor, sit amet.. \"]", "true,1", "[\"W\",\"XYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"Lorem ipsum, dolor, sit amet.. \"]", "[\"\",\"Lorem ipsum, dolor, sit amet.. \"]", "[\" Lor\",\"m ipsum, dolor, sit amet.. \"]", "false,2", "[\"W\",\"X\",\"YZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"orem ipsum, dolor, sit amet.. \"]", "[\"Lorem\",\"ipsum,\",\"dolor, sit amet.. \"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", "true,2", "[\"W\",\"X\",\"YZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcdefghijklmnopqrstuvw\"]", "[\"WXYZ[\\\\]^_`abcd\",\"fghijklmnopqrstuvw\"]", "[\" \",\"L\",\"orem ipsum, dolor, sit amet.. \"]", "[\"\",\"Lorem\",\"ipsum, dolor, sit amet.. \"]", "[\" Lor\",\"m ipsum, dolor, sit am\",\"t.. \"]", " Lorem ipsum, dolor, sit amet.. ", " Lorem ipsum, dolor, sit amet..", "Lorem ipsum, dolor, sit amet.. ", "Lorem ipsum, dolor, sit amet..", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "WXYZ[\\]^_`abcdefghijklmnopqrstuvw", " Lorem ipsum, dolor, sit amet.. ", "", "", "W", " ", "WX", " L", "", "", "XYZ[\\]^_`abcdefghijklmnopqrstuvw", "Lorem ipsum, dolor, sit amet.. ", "", "", "X", "L", "XY", "Lo", "", "", "YZ[\\]^_`abcdefghijklmnopqrstuvw", "orem ipsum, dolor, sit amet.. ", "", "", "Y", "o", "YZ", "or", "wxyz[\\]^_`abcdefghijklmnopqrstuvw", " lorem ipsum, dolor, sit amet.. ", 0, 0, 0, 0, 87, 32, 88, 76, 89, 111, false, false, false, true, false, false, false, false, true, true, null, "fom", "[null]", "[\"bar\",\"baz\",\"fom\",\"foo\"]", 1, 4, 374]
var index = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ss1 = "WXYZ[\\]^_`abcdefghijklmnopqrstuvw"
	var ss2 = " Lorem ipsum, dolor, sit amet.. "
	if true:
		for a in range(-2, 3):
			for b in range(-2, 3):
				for c in range(-2, 3):
					verify(clamp(a, b, c))
		for a in range(-2 * 4, 3 * 4):
			verify(int(a / 4.0))
		for a in range(-2 * 4, 3 * 4):
			verify(int(ceil(a / 4.0)))

		verify(ss1.begins_with(""))
		verify(ss1.begins_with("text"))
		verify(ss1.begins_with("WXYZ["))
		verify(ss1.containsn(""))
		verify(ss1.containsn("xy"))
		verify(ss1.containsn("Xy"))
		verify(ss1.containsn("WX"))
		verify(ss1.ends_with(""))
		verify(ss1.ends_with("Uvw"))
		verify(ss1.ends_with("uvw"))
		for a in range(-2, 3):
			verify(ss2.get_slice("", a))
			verify(ss2.get_slice(" ", a))
			verify(ss2.get_slice("e", a))
		verify(ss1.length())
		verify(ss2.length())
		for a in range(-2, 3):
			verify(ss1.rfind("", a))
			verify(ss1.rfind("w", a))
			verify(ss1.rfind("W", a))
			verify(ss2.rfind("e", a))
		for a in range(-2, 3):
			verify(ss1.right(a))
			verify(ss2.right(a))
		for a in range(-2, 3):
			for b in range(2):
				verify(str(bool(b), ",", a))
				verify(JSON.stringify(ss1.split("", bool(b), a)))
				verify(JSON.stringify(ss1.split(" ", bool(b), a)))
				verify(JSON.stringify(ss1.split("e", bool(b), a)))
				verify(JSON.stringify(ss2.split("", bool(b), a)))
				verify(JSON.stringify(ss2.split(" ", bool(b), a)))
				verify(JSON.stringify(ss2.split("e", bool(b), a)))

		for a in range(2):
			for b in range(2):
				verify(ss2.strip_edges(a, b))
		for a in range(-2, 3):
			for b in range(-2, 3):
				verify(ss1.substr(a, b))
				verify(ss2.substr(a, b))

		verify(ss1.to_lower())
		verify(ss2.to_lower())
		for a in range(-2, 3):
			verify(ss1.unicode_at(a))
			verify(ss2.unicode_at(a))

	var my_obj = {
		"foo": "bar",
		"baz": "fom"
	}
	var my_arr = [
		"foo", "bar",
		"baz", "fom"
	]
	var empty_arr = []

	verify(my_obj.has(""))
	verify(my_obj.has("fee"))
	verify(my_obj.has("fi"))
	verify(my_obj.has("foo"))
	verify(my_obj.has("fom"))

	verify(my_arr.has(""))
	verify(my_arr.has("fee"))
	verify(my_arr.has("fi"))
	verify(my_arr.has("foo"))
	verify(my_arr.has("fom"))

	verify(empty_arr.back())
	verify(my_arr.back())
	empty_arr.push_back(empty_arr.pop_front())
	my_arr.push_back(my_arr.pop_front())
	verify(JSON.stringify(empty_arr))
	verify(JSON.stringify(my_arr))
	if true:
		verify(empty_arr.size())
		verify(my_arr.size())

	verify(index)
	print("var answers = ", JSON.stringify(answers))


func verify(result):
	if index >= answers.size():
		answers.push_back(result)
	assert(answers[index] == result, "Wrong answer!")
	index += 1
