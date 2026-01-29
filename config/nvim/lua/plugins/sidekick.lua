return {
	{
		"folke/sidekick.nvim",
		keys = {
			{
				"<c-'>",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle",
				mode = { "n", "t", "i", "x" },
			},
		},
	},
}
