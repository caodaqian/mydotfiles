return  {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
	},
	{ 
		"Mofiqul/dracula.nvim",
		lazy = false,
		init = function()
			vim.g.dracula_transparent_bg = true
			vim.g.dracula_italic_comment = true
		end
	},
	{ 
		"navarasu/onedark.nvim",
		lazy = false,
		init = function()
			vim.o.backgroud = 'light'
		end,
		opts = {
			-- Main options --
			style = 'light', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = false, -- Show/hide background
			term_colors = true, -- Change terminal color as per the selected theme style
			ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
			-- toggle theme style ---
			toggle_style_list = {'light', 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'}, -- List of styles to toggle between
			toggle_style_key = '<leader>ts', -- Default keybinding to toggle

			-- Change code style ---
			-- Options are italic, bold, underline, none
			-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
			code_style = {
				comments = 'italic',
				keywords = 'none',
				functions = 'bold',
				strings = 'none',
				variables = 'none'
			},

			-- Custom Highlights --
			colors = {}, -- Override default colors
			highlights = {} -- Override highlight groups
		},
	},
}
