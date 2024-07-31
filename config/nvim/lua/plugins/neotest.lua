return {
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"nvim-neotest/neotest-python",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = function()
			return {
				-- your neotest config here
				adapters = {
					require("neotest-python")({
						runner = "pytest",
						dap = { justMyCode = false, console = "integratedTerminal" },
					}),
				},
			}
		end,
	},
}
