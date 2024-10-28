return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"go",
				"html",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"thrift",
				"proto",
				"vim",
				"vimdoc",
			},
			-- autopairs plugin
			autopairs = {
				enable = true,
			},
			-- Incremental selection based on the named nodes from the grammar.
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			prefer_git = true,
		},
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-refactor",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		require("nvim-treesitter.configs").setup({
	-- 			refactor = {
	-- 				highlight_definitions = {
	-- 					enable = true,
	-- 					-- Set to false if you have an `updatetime` of ~100.
	-- 					clear_on_cursor_move = true,
	-- 				},
	-- 				highlight_current_scope = { enable = true },
	-- 				smart_rename = {
	-- 					enable = true,
	-- 					-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
	-- 					keymaps = {
	-- 						smart_rename = "grr",
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
