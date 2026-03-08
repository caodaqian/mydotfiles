return {
	{
		"folke/sidekick.nvim",
		keys = {
			{
				"<M-/>",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle",
				mode = { "n", "t", "i", "x" },
			},
		},
		opts = {
			cli = {
				tools = {
					cline = { cmd = { "cline" } },
				},
			},
		},
	},
}
