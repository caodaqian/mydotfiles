return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"jbyuki/one-small-step-for-vimkind",
		},
		keys = {
			{ "<F9>",    "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "toggle breakpoints" },
			{ "<F5>",    "<cmd>lua require'dap'.continue()<cr>",          desc = "run/continue" },
			{ "<S-F5>",  "<cmd>lua require'dap'.close()<cr>",             desc = "close debug" },
			{ "<F10>",   "<cmd>lua require'dap'.step_over()<cr>",         desc = "step over" },
			{ "<F11>",   "<cmd>lua require'dap'.step_into()<cr>",         desc = "step into" },
			{ "<S-F11>", "<cmd>lua require'dap'.step_out()<cr>",          desc = "step out" },
		},
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
			local dap_breakpoint = {
				error = {
					text = "🔴",
					texthl = "LspDiagnosticsSignError",
					linehl = "",
					numhl = "",
				},
				rejected = {
					text = "🌟",
					texthl = "LspDiagnosticsSignHint",
					linehl = "",
					numhl = "",
				},
				stopped = {
					text = "➡️",
					texthl = "LspDiagnosticsSignInformation",
					linehl = "DiagnosticUnderlineInfo",
					numhl = "LspDiagnosticsSignInformation",
				},
			}
			vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
			vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
			vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

			-- set dap ui
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.disconnect["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
