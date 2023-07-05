return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig", -- enable LSP
		},
		config = function()
			require("mason-lspconfig").setup()
			-- Register a handler that will be called for all installed servers.
			-- Alternatively, you may also register handlers on specific server instances instead (see example below).
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if status_ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			else
				capabilities = nil
			end

			-- require lsp
			local function lsp_keymaps(bufnr)
				local opts = { noremap = true, silent = false }
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "=", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "v", "=", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "[e",
					"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "]e",
					"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>Q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>E", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
			end

			-- require lsp_keymaps
			local function lspsage_keymaps(bufnr)
				local opts = { noremap = true, silent = false }
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "v", "ga", "<cmd>Lspsaga code_action<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "[E",
					'<cmd>lua require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>',
					opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "]E",
					'<cmd>lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>',
					opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<A-d>", "<cmd>Lspsaga term_toggle<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "t", "<A-d>", "<cmd>Lspsaga term_toggle<CR>", opts)
			end
			local on_attach = function(client, bufnr)
				if require("lspsaga") then
					lspsage_keymaps(bufnr)
				else
					lsp_keymaps(bufnr)
				end
			end

			for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
				local opts = {
					on_attach = on_attach,
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 150,
					},
				}

				local status_ok, newopts = pcall(require, "lsp_settings." .. server_name)
				if status_ok then
					opts = vim.tbl_deep_extend("force", newopts, opts)
				end
				if server_name == "pyright" then
					local pyright_opts = require("lsp_settings.pyright")
					opts = vim.tbl_deep_extend("force", pyright_opts, opts)
				elseif server_name == "gopls" then
					local gopls_opts = require("lsp_settings.gopls")
					opts = vim.tbl_deep_extend("force", gopls_opts, opts)
				end
				require("lspconfig")[server_name].setup(opts)
			end
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			automatic_setup = true,
		},
		config = function()
			local function config_debuggers()
				local dap = require("dap")
				dap.defaults.fallback.terminal_win_cmd = "50vsplit new" -- this will be overrided by dapui
				-- show the debug console
				dap.defaults.fallback.console = "internalConsole"
			end

			config_debuggers() -- Debugger
			require("mason-nvim-dap").setup({
				handlers = {
					function(config)
						-- all sources with no handler get passed here
						-- Keep original functionality
						config_debuggers() -- Debugger
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
}
