return {
	{
		"hrsh7th/nvim-cmp", -- The completion plugin
		dependencies = {
			"hrsh7th/cmp-cmdline", -- cmdline completions
		},
		opts = function(_, opts)
			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			require("cmp").setup.cmdline(":", {
				sources = {
					{ name = "cmdline" },
					{ name = "path" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
