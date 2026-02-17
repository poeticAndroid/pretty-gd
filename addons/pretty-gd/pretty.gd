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
	token =  read_word ( )
	return  token
	
	
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
	
	
static func read(len=1):
	if is_eof():return ""
	pos+=len
	return input.substr(pos-len,len)

static func peek(len=1):
	if is_eof():return ""
	return input.substr(pos,len)

static func is_eol():
	return is_eof() or  peek()=="\n"

static func is_eof():
	return pos>=input.length()

const keywords = ["if", "else", "elif", "for", "while", "break", "continue",
  "pass", "return", "class", "class_name", "extends", "is", "as", "signal",
  "static", "const", "enum", "var", "breakpoint", "yield", "in", "and", "or"]
const longsymbols = ["**", "<<", ">>", "==", "!=", ">=", "<=", "&&", "||",
  "+=", "-=", "*=", "/=", "%=", "**=", "&=", "^=", "|=", "<<=", ">>=",
  ":=", "->"]
