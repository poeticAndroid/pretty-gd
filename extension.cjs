// CommonJS wrapper module triggers loading of the ES client module

let extension

// Create a proxy extension that just calls the one in the ES module
module.exports = {
  async activate(context) {
    // Load the ES module if it hasn't been loaded yet
    extension ??= await import("./extension.mjs")
    // Delegate to the ES module's activate method
    extension.activate(context)
  },
}


