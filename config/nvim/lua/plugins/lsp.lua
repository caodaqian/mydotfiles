return {
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},
	{
		"neovim/nvim-lspconfig", -- enable LSP
		lazy = false,
		init = function()
			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end

			local config = {
				-- disable virtual text
				virtual_text = true,
				-- show signs
				signs = {
					active = signs,
				},
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}
			vim.diagnostic.config(config)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		priority = 950,
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
		priority = 940,
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig", -- enable LSP
			{ "folke/neodev.nvim", ft = { "lua" }, opts = {} },
		},
		config = function()
			require("neodev").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
				automatic_installation = true,
			})
			-- Register a handler that will be called for all installed servers.
			-- Alternatively, you may also register handlers on specific server instances instead (see example below).
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if status_ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end
			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["rust_analyzer"] = function()
					require("rust-tools").setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.stdpath("config") .. "/lua"] = true,
									},
								},
							},
						},
						capabilities = capabilities,
					})
				end,
				["pyright"] = function()
					require("lspconfig").pyright.setup({
						cmd = { "pyright-langserver", "--stdio", "--lib", "--skipunannotated" },
						settings = {
							python = {
								analysis = {
									autoImportCompletions = true,
									autoSearchPaths = true,
									useLibraryCodeForTypes = true,
									diagnosticMode = "workspace",
									diagnosticSeverityOverrides = "none",
									-- typeCheckingMode = "off",
								},
							},
							pyright = {
								reportGeneralTypeIssues = "none",
								reportPropertyTypeMismatch = "info",
								reportFunctionMemberAccess = "info",
								reportMissingTypeStubs = "info",
								reportUnknownMemberType = "info",
								disableLanguageServices = false,
								disableOrganizeImports = false,
							},
						},
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						cmd = { "gopls" },
						root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						settings = {
							gopls = {
								completeUnimported = true,
								usePlaceholders = true,
								analyses = {
									unusedparams = true,
								},
							},
						},
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
	"ray-x/lsp_signature.nvim", -- show function signature when typing
	{
		"glepnir/lspsaga.nvim", --  enrich lsp
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig", -- enable LSP
			"williamboman/mason-lspconfig.nvim",
		},
		keys = {
			--[[ shuttle = '[w' shuttle bettween the finder layout window
			toggle_or_open = 'o' toggle expand or open
			vsplit = 's' open in vsplit
			split = 'i' open in split
			tabe = 't' open in tabe
			tabnew = 'r' open in new tab
			quit = 'q' quit the finder, only works in layout left window
			close = '<C-c>k' close finder ]]
			{
				"gh",
				"<cmd>Lspsaga finder ++inexist<CR>",
				desc = "open safa finder",
			},
			{
				"ga",
				"<cmd>Lspsaga code_action<CR>",
				desc = "code action",
			},
			--[[ quit = '<C-k>' quit rename window or project_replace window
			exec = '<CR>' execute rename in rename window or execute replace in project_replace window
			select = 'x' select or cancel select item in project_replace float window ]]
			{
				"<F2>",
				"<cmd>Lspsaga rename ++project<CR>",
				desc = "rename",
			},
			--[[ edit = '<C-c>o'
			vsplit = '<C-c>v'
			split = '<C-c>i'
			tabe = '<C-c>t'
			quit = 'q'
			close = '<C-c>k' ]]
			{
				"gd",
				"<cmd>Lspsaga peek_definition<CR>",
				desc = "peek definition",
			},
			{
				"gD",
				"<cmd>Lspsaga goto_definition<CR>",
				desc = "goto definition",
			},
			--[[ edit = 'e' edit (open) file
			vsplit = 's' vsplit
			split = 'i' split
			tabe = 't' open in new tab
			quit = 'q' quit layout
			shuttle = '[w' shuttle bettween the layout left and right
			toggle_or_req = 'u' toggle or do request
			close = '<C-c>k' close layout ]]
			{
				"gic",
				"<cmd>Lspsaga incoming_calls<CR>",
				desc = "imcoming calls",
			},
			{
				"goc",
				"<cmd>Lspsaga outgoing_calls<CR>",
				desc = "outgoing calls",
			},
			{
				"[e",
				"<cmd>Lspsaga diagnostic_jump_prev<CR>",
				desc = "prev diagnostic",
			},
			{
				"n",
				"[E",
				'<cmd>lua require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>',
				desc = "prev error diagnostic",
			},
			{
				"]e",
				"<cmd>Lspsaga diagnostic_jump_next<CR>",
				desc = "next diagnostic",
			},
			{
				"]E",
				'<cmd>lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>',
				desc = "noext error diagnostic",
			},
			{
				"gsb",
				"<cmd>Lspsaga show_buf_diagnostics ++normal<CR>",
				desc = "show buffer diagnostic",
			},
			{
				"gsw",
				"<cmd>Lspsaga show_workspace_diagnostics ++normal<CR>",
				desc = "show worksapce diagnostic",
			},
			--[[ max_width = 0.9 defines float window width
			max_height = 0.8 defines float window height
			open_link = 'gx' key for opening links
			open_cmd = '!chrome' cmd for opening links
			Press k twice to jump into the hover window and view the doc
			Press gx for open links ]]
			{
				"K",
				"<cmd>Lspsaga hover_doc<cr>",
				desc = "hover doc",
			},
			--[[ toggle_or_jump = 'o' toggle or jump
			quit = 'q' quit outline window
			jump = 'e' jump to pos even on a expand/collapse node ]]
			{
				"go",
				"<cmd>Lspsaga outline<cr>",
				desc = "safa outline",
			},
		},
		opts = {
			code_action = {
				extend_gitsigns = true,
			},
			hover = {
				cmd = "!edge",
			},
			lightbulb = {
				sign = false,
			},
			outline = {
				win_width = 45,
				auto_preview = true,
				layout = "float",
			},
		},
	},
	"j-hui/fidget.nvim", -- UI show lsp progress
}
