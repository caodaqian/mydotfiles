local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("plugs.lsp.handlers").setup()
require("plugs.lsp.lspsaga")
require("plugs.lsp.lsp-installer")
