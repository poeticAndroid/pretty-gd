// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode')
const tokenize = require("./tokenizer")

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed

/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {
  context.subscriptions.push(vscode.languages.registerDocumentFormattingEditProvider("gdscript", new GdDocumentFormatter()))
}

// this method is called when your extension is deactivated
function deactivate() { }

class GdDocumentFormatter {
  provideDocumentFormattingEdits(document) {
    let edits = []
    let indentLvl = 0
    let oneIndent
    let thisIndent
    let inString
    for (let lineNum = 0; lineNum < document.lineCount; lineNum++) {
      let line = document.lineAt(lineNum)
      if (inString) {
        if (line.text.includes("\"\"\"")) inString = false
        continue
      }
      let tokens = tokenize(line.text)
      if (!oneIndent) oneIndent = tokens[0]
      if (oneIndent) {
        indentLvl = tokens[0].length / oneIndent.length
      }
      thisIndent = ""
      for (let i = 0; i < indentLvl; i++) {
        thisIndent += oneIndent
      }
      tokens.shift()
      let newLine = (thisIndent + tokens.join("")).trimEnd()
      edits.push(vscode.TextEdit.replace(line.range, newLine))
      let lastToken = tokens.pop()
      if (lastToken && lastToken.slice(0, 3) === "\"\"\"" && !lastToken.includes("\"\"\"", 3)) inString = true
    }
    return edits
  }
}

module.exports = {
  activate,
  deactivate
}
