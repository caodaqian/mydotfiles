return {
	{
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
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
					active = signs
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
					prefix = ""
				}
			}
			vim.diagnostic.config(config)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
		end,
	},
	"ray-x/lsp_signature.nvim", -- show function signature when typing
	{
		'glepnir/lspsaga.nvim', --  enrich lsp
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig", -- enable LSP
			"williamboman/mason-lspconfig.nvim",
		},
		init = function ()
			local opts = { noremap = true, silent = false }
			--[[ shuttle = '[w' shuttle bettween the finder layout window
			toggle_or_open = 'o' toggle expand or open
			vsplit = 's' open in vsplit
			split = 'i' open in split
			tabe = 't' open in tabe
			tabnew = 'r' open in new tab
			quit = 'q' quit the finder, only works in layout left window
			close = '<C-c>k' close finder ]]
			vim.api.nvim_set_keymap("n", "gh", "<cmd>Lspsaga finder ++inexist<CR>", opts)
			vim.api.nvim_set_keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
			--[[ quit = '<C-k>' quit rename window or project_replace window
			exec = '<CR>' execute rename in rename window or execute replace in project_replace window
			select = 'x' select or cancel select item in project_replace float window ]]
			vim.api.nvim_set_keymap("n", "<F2>", "<cmd>Lspsaga rename ++project<CR>", opts)
			--[[ edit = '<C-c>o'
			vsplit = '<C-c>v'
			split = '<C-c>i'
			tabe = '<C-c>t'
			quit = 'q'
			close = '<C-c>k' ]]
			vim.api.nvim_set_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
			vim.api.nvim_set_keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)
			--[[ edit = 'e' edit (open) file
			vsplit = 's' vsplit
			split = 'i' split
			tabe = 't' open in new tab
			quit = 'q' quit layout
			shuttle = '[w' shuttle bettween the layout left and right
			toggle_or_req = 'u' toggle or do request
			close = '<C-c>k' close layout ]]
			vim.api.nvim_set_keymap("n", "gic", "<cmd>Lspsaga incoming_calls<CR>", opts)
			vim.api.nvim_set_keymap("n", "goc", "<cmd>Lspsaga outgoing_calls<CR>", opts)
			vim.api.nvim_set_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
			vim.api.nvim_set_keymap("n", "[E",
			'<cmd>lua require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>',
			opts)
			vim.api.nvim_set_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			vim.api.nvim_set_keymap("n", "]E",
			'<cmd>lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>',
			opts)
			vim.api.nvim_set_keymap("n", "gsb", "<cmd>Lspsaga show_buf_diagnostics ++normal<CR>",
			opts)
			vim.api.nvim_set_keymap("n", "gsw", "<cmd>Lspsaga show_workspace_diagnostics ++normal<CR>", opts)
			--[[ max_width = 0.9 defines float window width
			max_height = 0.8 defines float window height
			open_link = 'gx' key for opening links
			open_cmd = '!chrome' cmd for opening links
			Press k twice to jump into the hover window and view the doc
			Press gx for open links ]]
			vim.api.nvim_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
			--[[ toggle_or_jump = 'o' toggle or jump
			quit = 'q' quit outline window
			jump = 'e' jump to pos even on a expand/collapse node ]]
			vim.api.nvim_set_keymap("n", "go", "<cmd>Lspsaga outline<cr>", opts)
		end,
		opts = {
			code_action = {
				extend_gitsigns = true,
			},
			hover = {
				cmd = '!edge'
			},
			lightbulb = {
				sign = false,
			},
			outline = {
				win_width = 45,
				auto_preview = true,
				layout = 'float',
			}
		},
	},
	"j-hui/fidget.nvim", -- UI show lsp progress
}
