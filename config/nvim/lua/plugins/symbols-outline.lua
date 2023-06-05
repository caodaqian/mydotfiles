return {
	{
		"simrat39/symbols-outline.nvim",
		keys = {
			{ "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "symbols outline" },
		},
		config = function()
			require('symbols-outline').setup()
		end
	},
}
