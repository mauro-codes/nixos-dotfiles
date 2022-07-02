local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require ("mauro.lsp.lsp-installer")
require("mauro.lsp.handlers").setup()
require ("mauro.lsp.null-ls")
