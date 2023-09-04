return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor", -- Highlight definitions, navigation and rename powered by nvim-treesitter.
			"nvim-treesitter/nvim-treesitter-context", -- show class/function at the top
			"andymass/vim-matchup", -- highlight, navigate, and operate on sets of matching text
			"nvim-treesitter/playground", -- View treesitter information directly in Neovim
			"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"query",
					"typescript",
					"dart",
					"java",
					"python",
					"prisma",
					"bash",
					"go",
					"lua",
					"html",
					"vim",
					"markdown",
					"markdown_inline",
					"c",
					"tsx",
					"javascript",
					"css",
				},
				highlight = {
					enable = true, -- false will disable the whole extension
					use_languagetree = true,
					additional_vim_regex_highlighting = false,
					disable = {},
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						node_decremental = "<BS>",
						scope_incremental = "<TAB>",
					},
				},
				context_commentstring = {
					enable = true,
					config = {
						-- Languages that have a single comment style
						typescript = "// %s",
						css = "/* %s */",
						scss = "/* %s */",
						html = "<!-- %s -->",
						svelte = "<!-- %s -->",
						vue = "<!-- %s -->",
						json = "",
					},
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
				-- matchup plugin https://github.com/andymass/vim-matchup
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
					-- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
				},
				-- autopairs plugin
				autopairs = {
					enable = true,
				},
				refactor = {
					highlight_definitions = {
						enable = true,
						-- Set to false if you have an `updatetime` of ~100.
						clear_on_cursor_move = true,
					},
					highlight_current_scope = { enable = true },
				},
			})
		end,
	},
}
