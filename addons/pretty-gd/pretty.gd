class_name Prettifier

var indent_str = "\t"
var tab_size = 4

var input = ""
var pos = 0
var first_words = []
var last_token = ""


func prettify(_input: String) -> String:
	self.reset(_input)
	var output = ""
	var min_indent = 0
	var max_indent = 80
	while not self.is_eof():
		var line = self.read_line(min_indent, max_indent)
		if line.strip_edges():
			for first_token in self.first_words:
				if doubleblank.has(first_token):
					var i = output.rfind("\n\n")
					if i > 0: output = output.substr(0, i) + "\n" + output.substr(i)
			min_indent = 0
			max_indent = ceil(self.space_size(line) / self.tab_size) + 2
			output += line + "\n"
			if self.last_token == ":":
				max_indent += -1
				min_indent = max_indent
		elif not output.ends_with("\n\n"):
			min_indent = 0
			output += "\n"
	return output.strip_edges(false, true)


func reset(_input = self.input, _indent_str = self.indent_str, _tab_size = self.tab_size, _pos = 0):
	self.input = "" + _input
	self.indent_str = _indent_str
	self.tab_size = _tab_size
	self.pos = _pos
	if not self.indent_str: self.indent_str = "\t"
	self.tab_size = self.space_size(self.indent_str)
	self.first_words = []
	self.last_token = ""


func read_line(min_indent = 0, max_indent = 10):
	var line = self.read_whitespace()
	self.first_words = []
	self.last_token = ""
	if self.is_eol(): return self.read().strip_edges()
	#var indent = clamp(ceil((self.space_size(line) + self.tab_size - 1) / self.tab_size), min_indent, max_indent)
	var indent = clamp(ceil(self.space_size(line) / self.tab_size), min_indent, max_indent)
	line = ""
	for i in range(indent):
		line += self.indent_str
	var tokens = ["", "", ""]
	while not self.is_eol():
		tokens.push_back(self.read_token())
		while tokens.size() > 3: tokens.pop_front()
		line += self.between(tokens[0], tokens[1], tokens[2]) + tokens.back()
	self.first_words = self.get_first_words(line)
	line += self.read()
	return line.strip_edges(false, true)


func read_token():
	var token = ""
	self.read_whitespace()
	if self.peek() == "\n":
		token += self.read() + self.read_whitespace()
	elif longoperators.has(self.peek(4)):
		token += self.read(4)
	elif longoperators.has(self.peek(3)):
		token += self.read(3)
	elif longoperators.has(self.peek(2)):
		token += self.read(2)
	elif self.peek() == "#":
		token += self.read_until("\n")
	elif self.peek() == "@" and identifier.containsn(self.peek(1, 1)):
		token += self.read() + self.read_while(identifier)
	elif self.peek() == "." and number.containsn(self.peek(1, 1)):
		token += self.read_number()
	elif number.containsn(self.peek()):
		token += self.read_number()
	elif string.containsn(self.peek()) and quote.containsn(self.peek(1, 1)):
		token += self.read_string()
	elif quote.containsn(self.peek()):
		token += self.read_string()
	elif identifier.containsn(self.peek()):
		token += self.read_while(identifier)
	elif node.containsn(self.peek()):
		token += self.read_node()
	else:
		token += self.read()
	self.read_whitespace()
	if not token.begins_with("#"):
		self.last_token = token
	return token


func read_node():
	var token = self.read().to_lower()
	if quote.containsn(self.peek()):
		token += self.read_string()
	else:
		token += self.read_while(nodepath)
	return token


func read_string():
	var token = ""
	var quot = self.read().to_lower()
	if string.containsn(quot):
		token += quot
		quot = self.read()
	if self.peek(2) == quot + quot:
		quot += self.read(2)
	token += quot
	while not self.is_eof() && self.peek(quot.length()) != quot:
		if self.peek() == "\\": token += self.read(2)
		else: token += self.read(1)

	token += self.read(quot.length())
	return token


func read_number():
	var token = ""
	var reg = self.peek()
	while reg.containsn(self.peek()):
		token += self.read().to_lower()
		if token == ".": token = "0."
		if token == "0":
			reg = ".0123456789_bex"
			if "0123456789".containsn(self.peek()):
				token = ""
		elif token.begins_with("0x"): reg = "0123456789_abcdef"
		elif token.begins_with("0b"): reg = "01_"
		elif token.ends_with("e"): reg = "+-0123456789_"
		elif token.containsn("e"): reg = "0123456789_"
		elif token.containsn("."): reg = "0123456789_e"
		else: reg = ".0123456789_e"

	if token == "0x": token += "0"
	elif token == "0b": token += "0"
	elif token.ends_with("."): token += "0"
	elif token.ends_with("e"): token += "0"
	elif token.ends_with("-"): token += "0"
	elif token.ends_with("+"): token += "0"

	return token


func read_word():
	var token = ""
	while self.peek().strip_edges():
		token += self.read()
	return token


func read_whitespace():
	var token = ""
	while not self.is_eol() and not self.peek().strip_edges():
		token += self.read()
	return token


func read_while(charset):
	var output = ""
	while charset.containsn(self.peek()) or (charset.containsn("ø") and self.peek().unicode_at(0) > 127):
		output += self.read()
	return output


func read_until(delimiter):
	var output = ""
	while self.peek(delimiter.length()) != delimiter and not self.is_eof():
		output += self.read()
	return output


func read(len = 1):
	if self.is_eof(): return ""
	self.pos += len
	return self.input.substr(self.pos - len, len)


func peek(len = 1, skip = 0):
	if self.is_eof(): return ""
	return self.input.substr(self.pos + skip, len)


func is_eol():
	return self.is_eof() or self.peek() == "\n"


func is_eof():
	return self.pos >= self.input.length()


func between(token0, token1, token2):
	if !token1: return ""
	if !token2: return ""
	if token2.begins_with("#"): return "  "

	if sign.containsn(token1):
		if keywords.has(token0): return ""
		if parens_end.containsn(token0): return " "
		if quote.containsn(token0.right(1)): return " "
		if identifier.containsn(token0.right(1)): return " "
		return ""

	if token1 == "{": return " "
	if token2 == "}": return " "

	if parens_start.containsn(token1): return ""
	if longoperators.has(token1): return " "
	if longoperators.has(token2): return " "
	if operator.containsn(token1): return " "
	if operator.containsn(token2): return " "
	if comma.containsn(token1): return " "
	if comma.containsn(token2): return ""
	if keywords.has(token1): return " "
	if keywords.has(token2): return " "
	if parens.containsn(token1): return ""
	if parens.containsn(token2): return ""

	if identifier.containsn(token1.right(1)): return " "

	return ""


func get_first_words(line):
	return Array(line.strip_edges().get_slice("#", 0).get_slice("'", 0).get_slice('"', 0).split(" ", false))


func space_size(whitespace):
	if not whitespace: return 0
	if not self.tab_size: self.tab_size = 4
	var sum = 0
	for char in whitespace:
		if char == "\n":
			sum = 0
		elif char == "\t":
			sum += 1
			while sum % self.tab_size: sum += 1
		elif char == " ":
			sum += 1
		else:
			return sum
	return sum

const keywords = ["if", "else", "elif", "for", "while", "break", "continue",
	"pass", "return", "class", "class_name", "extends", "is", "as", "signal",
	"static", "const", "enum", "var", "breakpoint", "yield", "in", "and", "or"
]
const doubleblank = ["class", "func"]
const longoperators = ["**", "<<", ">>", "==", "!=", ">=", "<=", "&&", "||",
	"+=", "-=", "*=", "/=", "%=", "**=", "&=", "^=", "|=", "<<=", ">>=",
	":=", "->"
]
const operator = "%&*+-/<=>?\\^|"
const string = "r&^"
const quote = "\"\'"
const node = "$%"
const comma = ",;:"
const parens_start = "(["
const parens = "([.])"
const parens_end = "]})"
const sign = "!+-"
const number = "0123456789"
const identifier = "0123456789_abcdefghijklmnopqrstuvwxyzø"
const nodepath = "%/" + identifier
