class_name Prettifier

static var indent="\t"

static var input
static var pos

static func prettify(_input:String)->String:
	input=_input
	pos=0
	var output=""
	while not is_eof(): 
		output+=read_line() 	
	return output
	
		
static func read_line():
	var line=read_whitespace()
	while not is_eol ( ) :
		line +=  read_tøken()+" "
	line= line.strip_edges(false,true)+ read()
	return line
		

static func read_tøken() :
	var token=""
	read_whitespace ( )
	if longsymbols.has(peek(4)):
		token+=read(4)
	elif longsymbols.has(peek(3)):
		token+=read(3)
	elif longsymbols.has(peek(2)):
		token+=read(2)
	elif peek()=="#":
		token+=read_until("\n")
	elif peek()=="r" and string.contains(peek(1,1)) :
		token+=read()+read_string()
	elif peek()=="@" and identifier.contains(peek(1,1)):
		token+=read()+read_while(identifier)
	elif peek()=="." and number.contains(peek(1,1)) :
			token +=   read_number()
	elif number.contains(peek()):
		token+=  read_number()
	elif string.contains(peek()):
		token+=  read_string()
	elif identifier.contains(peek()):
		token+=read_while(identifier)
	elif node.contains(peek()):
		token+=  read_node()
	else:
		token+=read()
	return  token
	
	
	

static func read_node():
	var token = read()
	if string.contains(peek()):
		token += read_string()
	else:
		token+=read_while(nodepath)
	return token

static func read_string():
	var token=""
	var quot = read()
	if peek(2)==quot+quot:
		quot+=read(2)
	token+=quot
	while not is_eof() && peek(quot.length())!=quot:
		if peek()=="\\":token+=read(2)
		else:token+=read(1)

	token += read(quot.length())
	return token
	
static func read_number():
	var token=""
	var reg=peek() .to_lower()
	while reg.contains(peek().to_lower()):
		token += read().to_lower()
		if token == ".":  token="0."
		if token == "0":  
			reg = ".0123456789_bex"
			if "0123456789".contains(peek()):
				token = "" 
		elif token.begins_with( "0x"):  reg = "0123456789_abcdef"
		elif token.begins_with( "0b"):  reg = "01_"
		elif token. ends_with ("e"):  reg = "+-0123456789_"
		elif token.contains("e")  :reg = "0123456789_"
		elif token.contains("."):  reg = "0123456789_e"
		else:  reg = ".0123456789_e"
	

	if token == "0x": token += "0"
	elif token == "0b": token += "0"
	elif token.ends_with("."): token += "0"
	elif token.ends_with("e"): token += "0"
	elif token.ends_with("-"): token += "0"
	elif token.ends_with("+"): token += "0"

	return token

static func read_word():
	var token=""
	while  peek().strip_edges() :
		token+=read( )
	return token
	
static func read_whitespace():
	var token=""
	while not is_eol() and not peek().strip_edges() :
		token+=read( )
	return token

static  func read_while(charset)	:
	var output=""
	while charset .contains(peek()):
		output+=read()
	return output
	
	
static  func read_until(delimiter)	:
	var output=""
	while peek(delimiter.length())!=delimiter and not is_eof():
		output+=read()
	return output
	
static func read(len=1):
	if is_eof():return ""
	pos+=len
	return input.substr(pos-len,len)

static func peek(len=1,skip=0):
	if is_eof():return ""
	return input.substr(pos+skip,len)

static func is_eol():
	return is_eof()  or  peek()=="\n"

static func is_eof():
	return pos>=input.length()

const keywords = ["if", "else", "elif", "for", "while", "break", "continue",
  "pass", "return", "class", "class_name", "extends", "is", "as", "signal",
  "static", "const", "enum", "var", "breakpoint", "yield", "in", "and", "or"]
const longsymbols = ["**", "<<", ">>", "==", "!=", ">=", "<=", "&&", "||",
  "+=", "-=", "*=", "/=", "%=", "**=", "&=", "^=", "|=", "<<=", ">>=",
  ":=", "->"]
const string="\"\'"
const node="&$%^"
const sign="!+-"
const number="0123456789"
const identifier="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz"
const nodepath="%/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz"
