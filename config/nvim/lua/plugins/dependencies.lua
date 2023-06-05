return {
	{
		"lewis6991/impatient.nvim", -- Speed up loading Lua modules
		config = function()
			require("impatient").enable_profile()
		end,
	},
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"nvim-lua/popup.nvim",
	"nvim-tree/nvim-web-devicons", -- icons
}
