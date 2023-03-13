local status_ok, mason = pcall(require, "mason")
if not status_ok then
    vim.notify("mason not found!")
    return
end
local status_ok, mconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    vim.notify("mason-lspconfig not found!")
    return
end

mason.setup({
	ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
})
mconfig.setup()

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
local lspconfig = require("lspconfig")
for _, server_name in ipairs(mconfig.get_installed_servers()) do
    local opts = {
        on_attach = require("plugs.lsp.handlers").on_attach,
        capabilities = require("plugs.lsp.handlers").capabilities,
        flags = {
            debounce_text_changes = 150
        }
    }

	local status_ok, newopts = pcall(require, "plugs.lsp.settings." .. server_name)
	if status_ok then
		opts = vim.tbl_deep_extend("force", newopts, opts)
	end
    if server_name == "pyright" then
        local pyright_opts = require("plugs.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end
	lspconfig[server_name].setup(opts)
end

