return {
	{
		"folke/which-key.nvim",
		lazy = true,
		keys = { "<leader>" },
		config = function()
			require("which-key").setup()

			local opts = {
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps
			}

			local mappings = {
				E = {
					name = "telescope",
					r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
					f = { "<cmd>Telescope find_files<cr>", "find files" },
					F = {
						"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy())<cr>",
						"find text",
					},
					b = { "<cmd>Telescope buffers<cr>", "find buffers" },
					m = { "<cmd>Telescope vim_bookmarks all<cr>", "find bookmarks" },
					e = { "<cmd>Telescope env<cr>", "find ENV" },
					s = { "<cmd>Telescope symbol<cr>", "input emoji symbol" },
					c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
					h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
					M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
					R = { "<cmd>Telescope registers<cr>", "Registers" },
					k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
					C = { "<cmd>Telescope commands<cr>", "Commands" },
				},
				W = {
					name = "window",
					m = { "<cmd>WinShift<cr>", "move window" },
					j = { "<cmd>ToggleTerm direction=horizontal<cr>", "horizontal terminal" },
					l = { "<cmd>ToggleTerm direction=vertical<cr>", "vertical terminal" },
					k = { "<cmd>ToggleTerm direction=tab<cr>", "tab terminal" },
					h = { "<cmd>ToggleTerm direction=float<cr>", "float terminal" },
				},
				T = {
					name = "Test",
					c = { "<cmd>RunTestClear<cr>", "clear test buffer" },
					r = { "<cmd>RunTest<cr>", "run test" },
					t = { "<cmd>UltestSummary<CR>", "Unit Test" },
				},
				Q = {
					name = "Question",
					t = { "<cmd>Trouble<cr>", "ToggleTrouble" },
					d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
					w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
					q = { "<cmd>Trouble quickfix<cr>", "Quick Fix" },
					r = { "<cmd>Trouble lsp_references<cr>", "references of word" },
					f = { "<cmd>Trouble lsp_definitions<cr>", "references of word" },
				},
				D = {
					name = "Debug",
					c = { "<cmd>Telescope dap commands<cr>", "Dap command" },
					l = { "<cmd>Telescope dap list_breakpoints<cr>", "list breakpoints" },
					b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "add breakpoints" },
					v = { "<cmd>Telescope dap variables<cr>", "list variables" },
					C = { "<cmd>Telescope dap configurations<cr>", "list configurations" },
					f = { "<cmd>Telescope dap frame<cr>", "frame" },
					r = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
					e = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
					x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
					T = { "<cmd>lua require'dapui'.toggle('sidebar')<cr>", "Toggle Sidebar" },
					t = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
					p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
					q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
					k = { "<cmd>lua require'dapui'.eval()<cr>", "Dap UI eval" },
				},
				G = {
					name = "Git",
					f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
					x = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
					n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
					N = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
					l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
					r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
					R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
					s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
					S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
					u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
					U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
					o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
					b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
					c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
					d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff HEAD" },
				},
				R = {
					name = "Replace",
					f = { "<cmd>lua require('spectre').open_file_search()<CR>", "Replace File" },
					p = { "<cmd>lua require('spectre').open()<CR>", "Replace Project" },
					s = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search" },
				},
				L = {
					name = "LSP",
					l = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
					d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics" },
					w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
					f = { "<cmd>Format<cr>", "Format" },
					i = { "<cmd>LspInfo<cr>", "Info" },
					I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
					j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
					k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
					q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
					r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
					s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
					S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
				},
				H = {
					name = "Help",
					t = { "<cmd>TranslateW<cr>", "Translate this word" },
					T = { "<cmd>TSHighlightCapturesUnderCursor<cr>" },
				},
			}
			require("which-key").register(mappings, opts)
		end,
	},
}
