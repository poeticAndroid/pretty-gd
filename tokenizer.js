let pos, input, lastTokenType

function tokenize(_input) {
  pos = 0
  input = _input
  lastTokenType = null
  let tokens = [readWhitespace()]
  while (pos < input.length) {
    let char = input.charAt(pos)
    if (char === "#") {
      tokens.push((lastTokenType ? " " : "") + input.slice(pos))
      pos = input.length
    } else if (char === "@") {
      pos++
      tokens.push("@" + readName())
    } else if (char.match(/[\&\$\%\^]/) && input.charAt(pos + 1).trim()) {
      tokens.push(readNode())
    } else if (char === "-" && input.charAt(pos + 1).match(/[0-9\.a-z_A-Z]/)) {
      pos++
      if (input.charAt(pos).match(/[a-z_A-Z]/)) {
        tokens.push("-" + readName())
      } else {
        tokens.push("-" + readNumber())
      }
    } else if (char.match(/[a-z_A-Z]/)) {
      tokens.push(readName())
    } else if (char.match(/[0-9]/)) {
      tokens.push(readNumber())
    } else if (char.match(/[\[\]\(\)\{\}]/)) {
      tokens.push(char)
      pos++
      lastTokenType = "parens"
    } else if (char === "\"") {
      tokens.push(readString())
    } else {
      tokens.push(readSymbol())
    }
    readWhitespace()
  }
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
  if (isStickyType(lastTokenType)) token = " "
  while (input.charAt(pos).match(/[a-z_A-Z0-9]/)) {
    token += input.charAt(pos++)
  }
  if (keywords.includes(token.trim())) {
    if (lastTokenType && lastTokenType !== "keyword") token = " " + token.trim()
    token += " "
    lastTokenType = "keyword"
  } else {
    lastTokenType = "name"
  }
  return token
}
function readNode() {
  let token = ""
  if (isStickyType(lastTokenType)) token = " "
  if (!input.charAt(pos).match(/[\&\$\%\^]/)) return token
  token += input.charAt(pos++)
  if (input.charAt(pos) === "\"") {
    token += readString().trim()
  } else {
    while (input.charAt(pos).match(/[a-z_A-Z0-9\/\%]/)) {
      token += input.charAt(pos++)
    }
  }
  lastTokenType = "node"
  return token
}
function readNumber() {
  let token = ""
  if (isStickyType(lastTokenType)) token = " "
  while (input.charAt(pos).match(/[0-9.e\-\_]/)) {
    token += input.charAt(pos++)
  }
  lastTokenType = "number"
  return token
}
function readSymbol() {
  let token = " "
  if (lastTokenType === "symbol") token = ""
  while (pos < input.length && !input.charAt(pos).match(/[a-z_A-Z0-9\s#\$\[\]\(\)\{\}"]/)) {
    token += input.charAt(pos++)
  }
  token += " "
  if ([".", ",", "@", ":"].includes(token.trim().charAt(0))) {
    token = token.trim()
  }
  if (token === ",") {
    token += " "
  }
  lastTokenType = "symbol"
  return token
}
function readString() {
  let token = ""
  if (isStickyType(lastTokenType)) token = " "
  if (input.slice(pos, pos + 3) === "\"\"\"") {
    token += input.slice(pos, pos + 3)
    pos += 3
    while (pos < input.length && input.slice(pos, pos + 3) !== "\"\"\"") {
      token += input.charAt(pos++)
    }
    token += input.slice(pos, pos + 3)
    pos += 3
    lastTokenType = "string"
    return token
  }
  token += input.charAt(pos++)
  while (pos < input.length && input.charAt(pos) !== "\"") {
    token += input.charAt(pos++)
    if (input.charAt(pos - 1) === "\\") {
      token += input.charAt(pos++)
    }
  }
  token += input.charAt(pos++)
  lastTokenType = "string"
  return token
}

function isStickyType(type) {
  return type === "name" || type === "number" || type === "node"
}


const keywords = ["if", "elif", "else", "for", "while", "match", "break", "continue", "pass", "return", "class", "class_name", "extends", "is", "as", "self", "tool", "signal", "func", "static", "const", "enum", "var", "onready", "export", "setget", "breakpoint", "preload", "yield", "assert", "remote", "master", "puppet", "remotesync", "mastersync", "puppetsync",
  "in", "not", "and", "or"]
module.exports = tokenize
