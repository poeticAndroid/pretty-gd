let pos, input, lastTokenType

function tokenize(_input) {
  pos = 0
  input = _input
  lastTokenType = null
  console.log("tokenizing", input)
  let tokens = [readWhitespace()]
  while (pos < input.length) {
    let char = input.charAt(pos)
    if (char === "#") {
      tokens.push((lastTokenType ? " " : "") + input.slice(pos))
      pos = input.length
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
  if (lastTokenType === "name" || lastTokenType === "number") token = " "
  while (input.charAt(pos).match(/[a-z_A-Z0-9]/)) {
    token += input.charAt(pos++)
  }
  lastTokenType = "name"
  return token
}
function readNumber() {
  let token = ""
  if (lastTokenType === "name" || lastTokenType === "number") token = " "
  while (input.charAt(pos).match(/[0-9.e\-]/)) {
    token += input.charAt(pos++)
  }
  lastTokenType = "number"
  return token
}
function readSymbol() {
  let token = " "
  if (lastTokenType === "symbol") token = ""
  while (pos < input.length && !input.charAt(pos).match(/[a-z_A-Z0-9\s#\[\]\(\)\{\}"]/)) {
    token += input.charAt(pos++)
  }
  token += " "
  if ([".", ",", "@", "$"].includes(token.trim().charAt(0))) {
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
  if (lastTokenType === "name" || lastTokenType === "number") token = " "
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

module.exports = tokenize
