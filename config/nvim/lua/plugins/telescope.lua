return {
	{ "tom-anders/telescope-vim-bookmarks.nvim", dependencies = {"MattesGroeger/vim-bookmarks"} },
	{ "nvim-telescope/telescope-dap.nvim", dependencies = {"mfussenegger/nvim-dap"}, config = true },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		'nvim-telescope/telescope-hop.nvim',
		dependencies = {
			{
				"phaazon/hop.nvim",
				branch = "v2",
				config = function()
					-- you can configure Hop the way you like here; see :h hop-config
					require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
				end
			},
		},
	},
	{
		"folke/trouble.nvim",
		opt = {
			auto_close = true,
			use_diagnostic_signs = true,
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope-dap.nvim",
			"tom-anders/telescope-vim-bookmarks.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			"nvim-telescope/telescope-live-grep-raw.nvim",
			'nvim-telescope/telescope-hop.nvim',
			"LinArcX/telescope-env.nvim",
			"folke/trouble.nvim", -- better quick fix
		},
		keys = {
			{ "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
			{ "<leader>f", '<cmd>Telescope find_files<cr>', desc = "find files" },
			{ "<leader>F", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy())<cr>", desc = "find text" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "find buffers" },
		},
		config = function()
			-- disable preview binaries
			local previewers = require("telescope.previewers")
			Job = require("plenary.job")
			local new_maker = function(filepath, bufnr, opts)
				filepath = vim.fn.expand(filepath)
				Job:new({
					command = "file",
					args = { "--mime-type", "-b", filepath },
					on_exit = function(j)
						local mime_type = vim.split(j:result()[1], "/")[1]
						if mime_type == "text" then
							previewers.buffer_previewer_maker(filepath, bufnr, opts)
						else
							-- maybe we want to write something to the buffer here
							vim.schedule(function()
								vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
							end)
						end
					end
				}):sync()
			end
			local cur_cwd = function()
				local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					-- if not git then active lsp client root
					-- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps 
					if #vim.lsp.get_active_clients() ~= 0 then
						cwd = vim.lsp.get_active_clients()[1].config.root_dir
					end
				end
				return cwd
			end
			require('telescope').setup {
				defaults = {
					buffer_previewer_maker = new_maker,

					prompt_prefix = " ",
					selection_caret = " ",
					path_display = {
						smart = {},
					},
				},
				pickers = {
					find_files = {
						cwd = cur_cwd()
					},
					live_grep = {
						cwd = cur_cwd()
					},
				},
				extensions = {
					-- fzf syntax
					-- Token	Match type	Description
					-- sbtrkt	fuzzy-match	Items that match sbtrkt
					-- 'wild'	exact-match (quoted)	Items that include wild
					-- ^music	prefix-exact-match	Items that start with music
					-- .mp3$	suffix-exact-match	Items that end with .mp3
					-- !fire	inverse-exact-match	Items that do not include fire
					-- !^music	inverse-prefix-exact-match	Items that do not start with music
					-- !.mp3$	inverse-suffix-exact-match	Items that do not end with .mp3
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case" -- or "ignore_case" or "respect_case"
					},
					hop = {
						-- Highlight groups to link to signs and lines; the below configuration refers to demo
						-- sign_hl typically only defines foreground to possibly be combined with line_hl
						sign_hl = { "WarningMsg", "Title" },
						-- optional, typically a table of two highlight groups that are alternated between
						line_hl = { "CursorLine", "Normal" },
						-- options specific to `hop_loop`
						-- true temporarily disables Telescope selection highlighting
						clear_selection_hl = false,
						-- highlight hopped to entry with telescope selection highlight
						-- note: mutually exclusive with `clear_selection_hl`
						trace_entry = true,
						-- jump to entry where hoop loop was started from
						reset_selection = true,
					},
					["ui-select"] = { require("telescope.themes").get_dropdown {} },
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
					},
					playground = {
						enable = true,
						disable = {},
						updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
						persist_queries = false, -- Whether the query persists across vim sessions
						keybindings = {
							toggle_query_editor = 'o',
							toggle_hl_groups = 'i',
							toggle_injected_languages = 't',
							toggle_anonymous_nodes = 'a',
							toggle_language_display = 'I',
							focus_language = 'f',
							unfocus_language = 'F',
							update = 'R',
							goto_node = '<cr>',
							show_help = '?',
						},
					}
				},
				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},
			}
			require('telescope').load_extension('live_grep_args')
			require('telescope').load_extension('fzf')
			require('telescope').load_extension("ui-select")
			require('telescope').load_extension('dap')
			require('telescope').load_extension('vim_bookmarks')
			require('telescope').load_extension('hop')
			require('telescope').load_extension('env')
		end,
	},
}
