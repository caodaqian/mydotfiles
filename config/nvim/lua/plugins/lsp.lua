return {
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
		end
	},
	"kosayoda/nvim-lightbulb", -- code action
	"ray-x/lsp_signature.nvim", -- show function signature when typing
	{
		'glepnir/lspsaga.nvim', --  enrich lsp
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			--Please make sure you install markdown and markdown_inline parser
			"nvim-treesitter/nvim-treesitter"
		},
		config = true,
	},
	"j-hui/fidget.nvim", -- UI show lsp progress
}
