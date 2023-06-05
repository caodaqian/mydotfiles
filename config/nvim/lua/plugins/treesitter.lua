return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependenies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"romgrk/nvim-treesitter-context", -- show class/function at the top
			"andymass/vim-matchup", -- highlight, navigate, and operate on sets of matching text
			"nvim-treesitter/playground", -- View treesitter information directly in Neovim
			"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
		},
		opts = {
			highlight = {
				enable = true, -- false will disable the whole extension
				additional_vim_regex_highlighting = false,
				disable = {},
			},
			indent = {
				enable = true,
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
			textsubjects = {
				enable = true,
				keymaps = {
					["."] = "textsubjects-smart",
					[";"] = "textsubjects-big",
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
			rainbow = {
				enable = true,
				extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
				max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
			},
			autotag = {
				enable = true,
			},
			-- matchup plugin
			-- https://github.com/andymass/vim-matchup
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
				smart_rename = {
					enable = true,
					keymaps = {
						smart_rename = "grr",
					},
				},
				navigation = {
					enable = true,
					keymaps = {
						goto_definition = "gnd",
						list_definitions = "gnD",
						list_definitions_toc = "gO",
						goto_next_usage = "<a-*>",
						goto_previous_usage = "<a-#>",
					},
				},
			},
		},
	},
}
