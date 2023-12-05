let pos, input, tokenType

function tokenize(_input) {
  pos = 0
  input = _input
  tokenType = null
  let lastTokenType, token
  let tokens = [readWhitespace()]
  while (pos < input.length) {
    let char = input.charAt(pos)
    if (char === "#") {
      token = input.slice(pos).trim()
      tokenType = "comment"
      pos = input.length
    } else if (longsymbols.includes(input.slice(pos, pos + 4))) {
      token = input.slice(pos, pos + 4)
      pos += 4
      tokenType = "symbol"
    } else if (longsymbols.includes(input.slice(pos, pos + 3))) {
      token = input.slice(pos, pos + 3)
      pos += 3
      tokenType = "symbol"
    } else if (longsymbols.includes(input.slice(pos, pos + 2))) {
      token = input.slice(pos, pos + 2)
      pos += 2
      tokenType = "symbol"
    } else if (char === "@") {
      pos++
      token = "@" + readName()
      tokenType = "name"
    } else if (char.match(/[\&\$\%\^]/) && input.charAt(pos + 1).trim()) {
      token = readNode()
    } else if (char.match(/[\-\!]/) && input.charAt(pos + 1).match(/[0-9\.a-z_A-Z]/)) {
      pos++
      if (input.charAt(pos).match(/[a-z_A-Z]/)) {
        token = char + readName()
      } else {
        token = char + readNumber()
      }
    } else if (char === "." && input.charAt(pos + 1).match(/[0-9]/)) {
      token = readNumber()
    } else if (char.match(/[a-z_A-Z]/)) {
      token = readName()
    } else if (char.match(/[0-9]/)) {
      token = readNumber()
    } else if (char === "{") {
      pos++
      token = char
      tokenType = "curly"
    } else if (char.match(/[\[\]\(\)\{\}\.]/)) {
      pos++
      token = char
      tokenType = "parens"
    } else if (char === "\"" || char === "'") {
      token = readString()
    } else if (char === "," || char === ";" || char === ":") {
      pos++
      token = char
      tokenType = "comma"
    } else {
      pos++
      token = char
      tokenType = "symbol"
    }
    tokens.push(between(lastTokenType, tokenType) + "" + token)
    lastTokenType = tokenType
    readWhitespace()
  }
  // if (input !== tokens.join("")) console.log(input, tokens)
  return tokens
}

function readWhitespace() {
  let token = ""
  while (pos < input.length && !input.charAt(pos).trim()) {
    token += input.charAt(pos++)
  }
  return token
}

function readName() {
  let token = ""
  while (input.charAt(pos).match(/[a-z_A-Z0-9]/)) {
    token += input.charAt(pos++)
  }
  if (keywords.includes(token)) {
    tokenType = "keyword"
  } else {
    tokenType = "name"
  }
  return token
}
function readNode() {
  let token = ""
  if (!input.charAt(pos).match(/[\&\$\%\^]/)) return token
  token += input.charAt(pos++)
  if (input.charAt(pos) === "\"") {
    token += readString()
  } else {
    while (input.charAt(pos).match(/[a-z_A-Z0-9\/\%]/)) {
      token += input.charAt(pos++)
    }
  }
  tokenType = "node"
  return token
}
function readNumber() {
  let token = ""
  if (input.charAt(pos).match(/[0-9.e\-\_]/)) {
    token += input.charAt(pos++)
  }
  if (input.charAt(pos).match(/[0-9.e\-\_xb]/)) {
    token += input.charAt(pos++)
  }
  if (token === "0x") {
    while (input.charAt(pos).match(/[a-f0-9.e\-\_]/)) {
      token += input.charAt(pos++)
    }
  } else {
    while (input.charAt(pos).match(/[0-9.e\-\_]/)) {
      token += input.charAt(pos++)
    }
  }
  tokenType = "number"
  return token
}
function readString() {
  let token = ""
  if (input.slice(pos, pos + 3) === "\"\"\"") {
    token += input.slice(pos, pos + 3)
    pos += 3
    while (pos < input.length && input.slice(pos, pos + 3) !== "\"\"\"") {
      token += input.charAt(pos++)
    }
    token += input.slice(pos, pos + 3)
    pos += 3
    tokenType = "string"
    return token
  }
  token += input.charAt(pos++)
  let quot = token.trim().charAt(0)
  while (pos < input.length && input.charAt(pos) !== quot) {
    token += input.charAt(pos++)
    if (input.charAt(pos - 1) === "\\") {
      token += input.charAt(pos++)
    }
  }
  token += input.charAt(pos++)
  tokenType = "string"
  return token
}

function between(type1, type2) {
  if (!type1) return ""
  if (!type2) return ""
  if (type2 === "comment") return "  "

  if (type1 === "symbol") return " "
  if (type2 === "symbol") return " "
  if (type1 === "comma") return " "
  if (type2 === "comma") return ""
  if (type1 === "keyword") return " "
  if (type2 === "keyword") return " "
  if (type1 === "parens") return ""
  if (type2 === "parens") return ""

  if (type1 === "number") return " "
  if (type1 === "name") return " "
  if (type1 === "node") return " "
  return ""
}


const keywords = ["if", "else", "elif", "for", "while", "match", "break", "continue", "pass", "return", "class", "class_name", "extends", "is", "as",
  "tool", "signal", "static", "const", "enum", "var", "onready", "export", "setget", "breakpoint", "yield", "remote", "master",
  "puppet", "remotesync", "mastersync", "puppetsync", "in", "not", "and", "or"]
const longsymbols = ["**", "<<", ">>", "==", "!=", ">=", "<=", "&&", "||", "+=", "-=", "*=", "/=", "%=", "**=", "&=", "^=", "|=", "<<=", ">>=", ":=", "->"]
module.exports = tokenize
