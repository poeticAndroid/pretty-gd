# Everything after "#" is a comment.
# A file is a class!

# (optional) icon to show in the editor dialogs:
@icon("res://path/to/optional/icon.svg")

# (optional) class definition:
class_name MyClass

# Inheritance:
extends BaseClass


# Member variables.
var a = 5
var s = "Hello"
var arr = [1, 2, 3]
var dict = {"key": "value", 2: 3}
var other_dict = {key = "value", other_key = 2}
var typed_var: int
var inferred_type := "String"

# Constants.
const ANSWER = 42
const THE_NAME = "Charly"

# Enums.
enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
enum Named {THING_1, THING_2, ANOTHER_THING = -1}

# Built-in vector types.
var v2 = Vector2(1, 2)
var v3 = Vector3(1, 2, 3)


# Functions.
func some_function(param1, param2, param3):
	const local_const = 5

	if param1 < local_const:
		print(param1)
	elif param2 > 5:
		print(param2)
	else:
		print("Fail!")

	for i in range(20):
		print(i)

	while param2 != 0:
		param2 -= 1

	match param3:
		3:
			print("param3 is 3!")
		_:
			print("param3 is not 3!")

	var local_var = param1 + 3
	return local_var


# Functions override functions with the same name on the base/super class.
# If you still want to call them, use "super":
func something(p1, p2):
	super(p1, p2)


# It's also possible to call another function in the super class:
func other_something(p1, p2):
	super.something(p1, p2)


# Inner class
class Something:
	var a = 10


# Constructor
func _init():
	print("Constructed!")
	var lv = Something.new()
	print(lv.a)

# Numbers
12_345_678  # Equal to 12345678.
3.141_592_7  # Equal to 3.1415927.
0x8080_0000_ffff  # Equal to 0x80800000ffff.
0b11_00_11_00  # Equal to 0b11001100.

# Annotations

@export_range(1, 100, 1, "or_greater")
var ranged_var: int = 50

@onready
@export_node_path(TextEdit, LineEdit)
var input_field

@onready @export_node_path(TextEdit, LineEdit) var input_field

var my_label


func _ready():
	my_label = get_node("MyLabel")

@onready var my_label = get_node("MyLabel")

# This is a comment.

var a = 1 + \
2

var a = 1 + \
4 + \
10 + \
4

# Array
var arr = []
arr = [1, 2, 3]
var b = arr[1]  # This is 2.
var c = arr[arr.size() - 1]  # This is 3.
var d = arr[-1]  # Same as the previous line, but shorter.
arr[0] = "Hi!"  # Replacing value 1 with "Hi!".
arr.append(4)  # Array is now ["Hi!", 2, 3, 4].

# Dictionary
var d = {4: 5, "A key": "A value", 28: [1, 2, 3]}
d["Hi!"] = 0
d = {
	22: "value",
	"some_key": 2,
	"other_key": [2, 3, 4],
	"more_key": "Hello"
}

var d = {
	test22 = "value",
	some_key = 2,
	other_key = [2, 3, 4],
	more_key = "Hello",
	parensoup = {[{[{}, [], {}]}]}
	}

var d = {}  # Create an empty Dictionary.
d.waiting = 14  # Add String "waiting" as a key and assign the value 14 to it.
d[4] = "hello"  # Add integer 4 as a key and assign the String "hello" as its value.
d["Godot"] = 3.01  # Add String "Godot" as a key and assign the value 3.01 to it.

var test = 4
# Prints "hello" by indexing the dictionary with a dynamic key.
# This is not the same as `d.test`. The bracket syntax equivalent to
# `d.test` is `d["test"]`.
print(d[test])

# Variables
var a  # Data type is 'null' by default.
var b = 5
var c = 3.8
var d = b + c  # Variables are always initialized in order.

var my_vector2: Vector2
var my_node: Node = Sprite2D.new()

var my_vector2 := Vector2()  # 'my_vector2' is of type 'Vector2'.
var my_node := Sprite2D.new()  # 'my_node' is of type 'Sprite2D'.

# Casting
var my_node2D: Node2D
my_node2D = $Sprite2D as Node2D  # Works since Sprite2D is a subtype of Node2D.

var my_node2D: Node2D
my_node2D = $Button as Node2D  # Results in 'null' since a Button is not a subtype of Node2D.

var my_int: int
my_int = "123" as int  # The string can be converted to int.
my_int = Vector2() as int  # A Vector2 can't be converted to int, this will cause an error.

# Will infer the variable to be of type Sprite2D.
var my_sprite := $Character as Sprite2D

# Will fail if $AnimPlayer is not an AnimationPlayer, even if it has the method 'play()'.
($AnimPlayer as AnimationPlayer).play("walk")

# Constants
const A = 5
const B = Vector2(20, 20)
const C = 10 + 20  # Constant expression.
const D = Vector2(20, 30).x  # Constant expression: 20.
const E = [1, 2, 3, 4][0]  # Constant expression: 1.
const F = sin(20)  # 'sin()' can be used in constant expressions.
const G = x + 20  # Invalid; this is not a constant expression!
const H = A + 20  # Constant expression: 25 (`A` is a constant).

const A: int = 5
const B: Vector2 = Vector2()

# Enums
enum {TILE_BRICK, TILE_FLOOR, TILE_SPIKE, TILE_TELEPORT}
# Is the same as:
const TILE_BRICK = 0
const TILE_FLOOR = 1
const TILE_SPIKE = 2
const TILE_TELEPORT = 3

enum State {STATE_IDLE, STATE_JUMP = 5, STATE_SHOOT}
# Is the same as:
const State = {STATE_IDLE = 0, STATE_JUMP = 5, STATE_SHOOT = 6}
# Access values with State.STATE_IDLE, etc.

# Functions
func my_function(a, b):
	print(a)
	print(b)
	return a + b  # Return is optional; without it 'null' is returned.

func square(a): return a * a

func hello_world(): print("Hello World")

func empty_function(): pass

func my_function(a: int, b: String):
	pass

func my_function(int_arg := 42, String_arg := "string"):
	pass

func my_int_function() -> int:
	return 0

func void_function() -> void:
	return  # Can't return a value.

# Referencing functions
func map(arr: Array, function: Callable) -> Array:
	var result = []
	for item in arr:
		result.push_back(function.call(item))
	return result

func add1(value: int) -> int:
	return value + 1;

func _ready() -> void:
	var my_array = [1, 2, 3]
	var plus_one = map(my_array, add1)
	print(plus_one)  # Prints [2, 3, 4].

# Lambda functions
var lambda = func(x): print(x)
lambda.call(42)  # Prints "42"

var lambda = func my_lambda(x):
	print(x)

var x = 42
var my_lambda = func(): print(x)
my_lambda.call()  # Prints "42"
x = "Hello"
my_lambda.call()  # Prints "42"

# Static functions
static func sum2(a, b):
	return a + b

# Expressions
2 + 2  # Binary operation.
-5  # Unary operation.
"okay" if x > 4 else "not okay"  # Ternary operation.
x  # Identifier representing variable or constant.
x.a  # Attribute access.
x[4]  # Subscript access.
x > 2 or x < 5  # Comparisons and logic operators.
x == y + 2  # Equality test.
do_something()  # Function call.
[1, 2, 3]  # Array definition.
{A = 1, B = 2}  # Dictionary definition.
preload("res://icon.png")  # Preload builtin function.
self  # Reference to current instance.

speed += -brake

if !some_variable && !some_other_variable:
	pass

# if/else/elif
if (expression):
	statement(s)
elif (expression):
	statement(s)
else:
	statement(s)

if 1 + 1 == 2: return 2 + 2
else:
	var x = 3 + 3
	return x

var x = (value) if (expression) else (value)
y += 3 if y < 10 else -1

var count = 0

var fruit = (
	"apple" if count == 2
	else "pear" if count == 1
	else "banana" if count == 0
	else "orange"
)
print(fruit)  # banana

# Alternative syntax with backslashes instead of parentheses (for multi-line expressions).
# Less lines required, but harder to refactor.
var fruit_alt = \
	"apple" if count == 2 \
	else "pear" if count == 1 \
	else "banana" if count == 0 \
	else "orange"
print(fruit_alt)  # banana

# Check if a letter is in a string.
var text = "abc"
if 'b' in text: print("The string contains b")

# Check if a variable is contained within a node.
if "varName" in get_parent(): print("varName is defined in parent!")

# while
while (expression):
	statement(s)

# for
for x in [5, 7, 11]:
	statement  # Loop iterates 3 times with 'x' as 5, then 7 and finally 11.

var dict = {"a": 0, "b": 1, "c": 2}
for i in dict:
	print(dict[i])  # Prints 0, then 1, then 2.

for i in range(3):
	statement  # Similar to [0, 1, 2] but does not allocate an array.

for i in range(1, 3):
	statement  # Similar to [1, 2] but does not allocate an array.

for i in range(2, 8, 2):
	statement  # Similar to [2, 4, 6] but does not allocate an array.

for c in "Hello":
	print(c)  # Iterate through all characters in a String, print every letter on new line.

for i in 3:
	statement  # Similar to range(3).

for i in 2.2:
	statement  # Similar to range(ceil(2.2)).

for i in array.size():
	array[i] = "Hello World"

for string in string_array:
	string = "Hello World"  # This has no effect

for node in node_array:
	node.add_to_group("Cool_Group")  # This has an effect

# match
match (expression):
	[pattern](s):
		[block]
	[pattern](s):
		[block]
	[pattern](s):
		[block]

match x:
	1:
		print("We are number one!")
	2:
		print("Two are better than one!")
	"test":
		print("Oh snap! It's a string!")

match typeof(x):
	TYPE_FLOAT:
		print("float")
	TYPE_STRING:
		print("text")
	TYPE_ARRAY:
		print("array")

match x:
	1:
		print("It's one!")
	2:
		print("It's one times two!")
	_:
		print("It's not 1 or 2. I don't care to be honest.")

match x:
	1:
		print("It's one!")
	2:
		print("It's one times two!")
	var new_var:
		print("It's not 1 or 2, it's ", new_var)

match x:
	[]:
		print("Empty array")
	[1, 3, "test", null]:
		print("Very specific array")
	[ var start, _, "test"]:
		print("First element is ", start, ", and the last is \"test\"")
	[42, ..]:
		print("Open ended array")

match x:
	{}:
		print("Empty dict")
	{"name": "Dennis"}:
		print("The name is Dennis")
	{"name": "Dennis", "age": var age}:
		print("Dennis is ", age, " years old.")
	{"name", "age"}:
		print("Has a name and an age, but it's not Dennis :(")
	{"key": "godotisawesome", ..}:
		print("I only checked for one entry and ignored the rest")

match x:
	1, 2, 3:
		print("It's 1 - 3")
	"Sword", "Splash potion", "Fist":
		print("Yep, you've taken damage")

# Classes
# Inherit from 'Character.gd'.

extends "res://path/to/character.gd"

# Load character.gd and create a new node instance from it.

var Character = load("res://path/to/character.gd")
var character_node = Character.new()

# Item.gd

@icon("res://interface/icons/item.png")
class_name Item
extends Node

# Saved as a file named 'character.gd'.

class_name Character


var health = 5


func print_health():
	print(health)


func print_this_script_three_times():
	print(get_script())
	print(ResourceLoader.load("res://character.gd"))
	print(Character)

class_name MyNode extends Node

# Inherit/extend a globally available class.
extends SomeClass

# Inherit/extend a named class file.
extends "somefile.gd"

# Inherit/extend an inner class in another file.
extends "somefile.gd".SomeInnerClass

# Cache the enemy class.
const Enemy = preload("enemy.gd")

# [...]

# Use 'is' to check inheritance.
if entity is Enemy:
	entity.apply_damage()

super(args)

func some_func(x):
	super(x)  # Calls the same function on the super class.

func overriding():
	return 0  # This overrides the method in the base class.

func dont_override():
	return super.overriding()  # This calls the method as defined in the base class.

func _init(arg):
	super("some_default", arg)  # Call the custom base constructor.

# State.gd (inherited class).
var entity = null
var message = null


func _init(e = null):
	entity = e


func enter(m):
	message = m


# Idle.gd (inheriting class).
extends "State.gd"


func _init(e = null, m = null):
	super(e)
	# Do something with 'e'.
	message = m

# Idle.gd

func _init():
	super(5)

# Inside a class file.

# An inner class in this class file.
class SomeInnerClass:
	var a = 5


	func print_value_of_a():
		print(a)


# This is the constructor of the class file's main class.
func _init():
	var c = SomeInnerClass.new()
	c.print_value_of_a()

# Load the class resource when calling load().
var MyClass = load("myclass.gd")

# Preload the class only once at compile time.
const MyClass = preload("myclass.gd")


func _init():
	var a = MyClass.new()
	a.some_function()

# Exports
var milliseconds: int = 0
var seconds: int:
	get:
		return milliseconds / 1000
	set(value):
		milliseconds = value * 1000

var my_prop:
	get = get_my_prop, set = set_my_prop

@tool
extends Button

func _ready():
	print("Hello")

extends Node

var my_file_ref

func _ready():
	var f = File.new()
	my_file_ref = weakref(f)
	# the File class inherits RefCounted, so it will be freed when not in use

	# the WeakRef will not prevent f from being freed when other_node is finished
	other_node.use_file(f)

func _this_is_called_later():
	var my_file = my_file_ref.get_ref()
	if my_file:
		my_file.close()

extends Node


# A signal named health_depleted.
signal health_depleted

# Game.gd

func _ready():
	var character_node = get_node('Character')
	character_node.health_depleted.connect(_on_Character_health_depleted)


func _on_Character_health_depleted():
	get_tree().reload_current_scene()

# Character.gd

...
signal health_changed


func take_damage(amount):
	var old_health = health
	health -= amount

	# We emit the health_changed signal every time the
	# character takes damage.
	health_changed.emit(old_health, health)
...

# Lifebar.gd

# Here, we define a function to use as a callback when the
# character's health_changed signal is emitted.

...
func _on_Character_health_changed(old_value, new_value):
	if old_value > new_value:
		progress_bar.modulate = Color.RED
	else:
		progress_bar.modulate = Color.GREEN

	# Imagine that `animate` is a user-defined function that animates the
	# bar filling up or emptying itself.
	progress_bar.animate(old_value, new_value)
...

# Game.gd

func _ready():
	var character_node = get_node('Character')
	var lifebar_node = get_node('UserInterface/Lifebar')

	character_node.health_changed.connect(lifebar_node._on_Character_health_changed)

# Defining a signal that forwards two arguments.
signal health_changed(old_value, new_value)

# Game.gd

func _ready():
	var character_node = get_node('Character')
	var battle_log_node = get_node('UserInterface/BattleLog')

	character_node.health_changed.connect(battle_log_node._on_Character_health_changed, [character_node.name])

# BattleLog.gd

func _on_Character_health_changed(old_value, new_value, character_name):
	if not new_value <= old_value:
		return

	var damage = old_value - new_value
	label.text += character_name + " took " + str(damage) + " damage."

func wait_confirmation():
	print("Prompting user")
	await $Button.button_up  # Waits for the button_up signal from Button node.
	print("User confirmed")
	return true

func request_confirmation():
	print("Will ask the user")
	var confirmed = await wait_confirmation()
	if confirmed:
		print("User confirmed")
	else:
		print("User cancelled")

func wrong():
	var confirmed = wait_confirmation()  # Will give an error.

func okay():
	wait_confirmation()
	print("This will be printed immediately, before the user press the button.")

func no_wait():
	var x = await get_five()
	print("This doesn't make this function a coroutine.")

func get_five():
	return 5

func get_signal():
	return $Button.button_up

func wait_button():
	await get_signal()
	print("Button was pressed")

# Check that 'i' is 0. If 'i' is not 0, an assertion error will occur.
assert(i == 0)

assert(enemy_power < 256, "Enemy is too powerful!")
