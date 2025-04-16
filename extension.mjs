

// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import vscode from "./vscode.cjs"
import pretty from "pretty-gd-js"

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed

/**
 * @param {vscode.ExtensionContext} context
 */
export function activate(context) {
    context.subscriptions.push(vscode.languages.registerDocumentFormattingEditProvider("gdscript", new GdDocumentFormatter()))
}

// this method is called when your extension is deactivated
export function deactivate() { }

class GdDocumentFormatter {
    provideDocumentFormattingEdits(document) {
        let edits = []
        let lines = ""
        for (let lineNum = 0; lineNum < document.lineCount; lineNum++) {
            let line = document.lineAt(lineNum)
            lines += line.text + "\n"
        }
        lines = pretty.prettify(lines) + "\n"

        let range = new vscode.Range(document.lineAt(0).range.start, document.lineAt(document.lineCount - 1).range.end)
        edits.push(vscode.TextEdit.replace(range, lines))
        return edits
    }
}

