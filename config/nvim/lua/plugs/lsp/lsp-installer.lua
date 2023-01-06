local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    vim.notify("nvim-lsp-installer not found!")
    return
end

lsp_installer.setup({
	automatic_installation = true,
})

-- NOTE: 如果发现某些lsp server安装启动时出现， client exit x and signal 0 等错误
-- 可能是因为node版本过低， 升级node版本即可
-- 升级方法
-- npm cache clean -f
-- npm install -g n
-- n stable

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
local lspconfig = require("lspconfig")
for _, server in ipairs(lsp_installer.get_installed_servers()) do
    local opts = {
        on_attach = require("plugs.lsp.handlers").on_attach,
        capabilities = require("plugs.lsp.handlers").capabilities,
        flags = {
            debounce_text_changes = 150
        }
    }

	local status_ok, newopts = pcall(require, "plugs.lsp.settings." .. server.name)
	if status_ok then
		opts = vim.tbl_deep_extend("force", newopts, opts)
	end
    if server.name == "pyright" then
        local pyright_opts = require("plugs.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end
    --if server.name == "clangd" then
    --    local clangd_opts = require("plugs.lsp.settings.clangd")
    --    opts = vim.tbl_deep_extend("force", clangd_opts, opts)
	--elseif server.name == "jsonls" then
    --    local jsonls_opts = require("plugs.lsp.settings.jsonls")
    --    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	--elseif server.name == "sumneko_lua" then
    --    local sumneko_opts = require("plugs.lsp.settings.sumneko_lua")
    --    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	--elseif server.name == "pyright" then
    --    local pyright_opts = require("plugs.lsp.settings.pyright")
    --    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	--elseif server.name == "bashls" then
	--	local bashls_opts = require("plugs.lsp.settings.bashls")
	--	opts = vim.tbl_deep_extend("force", bashls_opts, opts)
	--elseif server.name == "eslint" then
	--	local eslint_opts = require("plugs.lsp.settings.eslint")
	--	opts = vim.tbl_deep_extend("force", eslint_opts, opts)
    --end

	lspconfig[server.name].setup(opts)
end
