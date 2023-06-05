return {
	{
		"lmburns/lf.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		lazy = false,
		dependencies = {
			"plenary.nvim",
			'toggleterm.nvim',
		},
		init = function ()
			vim.g.lf_netrw = 1
		end,
		config = function()
			-- This feature will not work if the plugin is lazy-loaded
			vim.g.lf_netrw = 1

			require("lf").setup({
				escape_quit = false,
				border = "rounded",
			})
		end
	},
}
