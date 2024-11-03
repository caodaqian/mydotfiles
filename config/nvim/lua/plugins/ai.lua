return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function(_, opts)
			require("supermaven-nvim").setup({
				disable_keymaps = true,
			})
		end,
	},
}
