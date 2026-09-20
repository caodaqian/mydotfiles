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
			copilot = {
				status = {
					level = vim.log.levels.OFF,
				},
			},
		},
	},
	{
		"WorksOnMyVM/herdr-agent-bridge.nvim",
		main = "herdr_agent",
		dependencies = { "folke/sidekick.nvim" },
		lazy = false,
		opts = {
			context = { provider = "auto" }, -- auto 会自动接 sidekick
			pane = { size = 0.30 },
			keymaps = {
				toggle = "aa", -- <leader>aa 切换 Agent View / Code View
				send_this = "at", -- <leader>at 发送 {this}
				send_file = "af", -- <leader>af 发送 {file}
				send_selection = "av", -- <leader>av 发送 {selection}
				prompt = "ap", -- <leader>ap 提示词库
			},
		},
	},
}
