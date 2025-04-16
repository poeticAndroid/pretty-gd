// The `vscode` module isn't an npm package but is provided by the VS Code
// extension host environment. This is only made available to CommonJS modules
// but is needed on the ES side. We obtain a reference here so that ES modules
// can import it.

const vscode = require("vscode")
module.exports = vscode