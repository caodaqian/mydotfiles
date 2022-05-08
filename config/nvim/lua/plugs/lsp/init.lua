local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("plugs.lsp.lsp-installer")
require("plugs.lsp.handlers").setup()
require('plugs.lsp.fidget')
-- require("plugs.lsp.null-ls")
-- require("plugs.lsp.lsp-utils")
