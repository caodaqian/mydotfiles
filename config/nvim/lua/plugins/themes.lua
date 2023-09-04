return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.05, -- percentage of the shade to apply to the inactive window
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					mini = true,
					fidget = true,
					hop = true,
					leap = true,
					lsp_saga = true,
					mason = true,
					neotree = true,
					noice = true,
					treesitter_context = true,
					telescope = {
						enabled = true,
						-- style = "nvchad",
					},
					which_key = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		name = "dracula",
		lazy = false,
		init = function()
			vim.g.dracula_transparent_bg = true
			vim.g.dracula_italic_comment = true
		end,
	},
	{
		"neanias/everforest-nvim",
		name = "everforest",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				background = "medium",
				italics = true,
			})
		end,
	},
	{
		"ayu-theme/ayu-vim",
		name = "ayu",
		lazy = false,
		init = function()
			vim.g.ayucolor = "light"
		end,
	},
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		lazy = false,
		init = function()
			vim.o.backgroud = "dark"
		end,
		opts = {
			-- Main options --
			style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = false, -- Show/hide background
			term_colors = true, -- Change terminal color as per the selected theme style
			ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
			-- toggle theme style ---
			toggle_style_list = { "light", "dark", "darker", "cool", "deep", "warm", "warmer" }, -- List of styles to toggle between
			toggle_style_key = "<leader>ts", -- Default keybinding to toggle

			-- Change code style ---
			-- Options are italic, bold, underline, none
			-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
			code_style = {
				comments = "italic",
				keywords = "none",
				functions = "bold",
				strings = "none",
				variables = "none",
			},

			-- Custom Highlights --
			colors = {}, -- Override default colors
			highlights = {}, -- Override highlight groups
		},
	},
}
