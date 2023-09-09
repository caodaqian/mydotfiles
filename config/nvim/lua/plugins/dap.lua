return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"jbyuki/one-small-step-for-vimkind",
		},
		keys = {
			{ "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "toggle breakpoints" },
			{ "<F5>", "<cmd>lua require'dap'.continue()<cr>", desc = "run/continue" },
			{ "<S-F5>", "<cmd>lua require'dap'.close()<cr>", desc = "close debug" },
			{ "<F10>", "<cmd>lua require'dap'.step_over()<cr>", desc = "step over" },
			{ "<F11>", "<cmd>lua require'dap'.step_into()<cr>", desc = "step into" },
			{ "<S-F11>", "<cmd>lua require'dap'.step_out()<cr>", desc = "step out" },
		},
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
			require("dap.ext.vscode").load_launchjs()
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

			-- map K to hover while session is active
			local keymap_restore = {}
			require("dap").listeners.after["event_initialized"]["me"] = function()
				for _, buf in pairs(vim.api.nvim_list_bufs()) do
					local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
					for _, keymap in pairs(keymaps) do
						if keymap.lhs == "K" then
							table.insert(keymap_restore, keymap)
							vim.api.nvim_buf_del_keymap(buf, "n", "K")
						end
					end
				end
				vim.api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
			end
			require("dap").listeners.after["event_terminated"]["me"] = function()
				for _, keymap in pairs(keymap_restore) do
					vim.api.nvim_buf_set_keymap(
						keymap.buffer,
						keymap.mode,
						keymap.lhs,
						keymap.rhs,
						{ silent = keymap.silent == 1 }
					)
				end
				keymap_restore = {}
			end

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
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = false,
		priority = 940,
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			local function config_debuggers()
				local dap = require("dap")
				dap.defaults.fallback.terminal_win_cmd = "50vsplit new" -- this will be overrided by dapui
				-- show the debug console
				dap.defaults.fallback.console = "internalConsole"
			end

			require("mason").setup()
			require("mason-nvim-dap").setup({
				ensure_installed = { "python", "delve", "stylua", "javatest", "javadbg" },
				automatic_setup = true,
				handlers = {
					function(config)
						-- all sources with no handler get passed here
						-- Keep original functionality
						config_debuggers() -- Debugger
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
}
