class_name Prettifier

static var input
static var pos

static func prettify(_input:String)->String:
	input=_input
	pos=0
	while not is_eof(): 
		print(read_token() )	
	return ""
	
		
static func read_line():
	pass
		

static func read_token():
	var token=""
	while not ( is_eof() or peek().strip_edges() ):
		read()
	while not is_eof() and peek().strip_edges() :
		token+=read( )
	return token
	
	
static func read():
	if is_eof():return ""
	var char= input[pos]
	pos+=1
	return char

static func peek():
	if is_eof():return ""
	return input[pos]

static func is_eof():
	return pos>=input.length()
