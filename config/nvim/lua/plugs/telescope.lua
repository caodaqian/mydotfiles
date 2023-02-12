local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require "telescope.actions"
local trouble = require 'trouble.providers.telescope'

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

telescope.setup {
	defaults = {
		buffer_previewer_maker = new_maker,

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = {
			shorten = {
				-- e.g. for a path like
				--   `alpha/beta/gamma/delta.txt`
				-- setting `path_display.shorten = { len = 1, exclude = {1, -1} }`
				-- will give a path like:
				--   `alpha/b/g/delta.txt`
				len = 3,
				exclude = { 1, -1 }
			}
		},

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = trouble.open_with_trouble,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<C-h>"] = telescope.extensions.hop.hop,
				["<C-l>"] = actions.complete_tag,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = function(prompt_bufnr)
					local opts = {
						callback = actions.toggle_selection,
						loop_callback = actions.send_selected_to_qflist,
					}
					require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
				end,
				["<C-?>"] = actions.which_key -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = trouble.open_with_trouble,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key
			}
		}
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

telescope.load_extension('live_grep_args')
telescope.load_extension('fzf')
telescope.load_extension("ui-select")
telescope.load_extension('dap')
telescope.load_extension('vim_bookmarks')
--telescope.load_extension('aerial')
telescope.load_extension('hop')
-- <cr>	append environment name to buffer
-- <c-a>	append environment value to buffer
-- <c-e>	edit environment value(for the current session)
telescope.load_extension('env')
--<C-o>	Open online repository
--<C-f>	Open with find_files
--<C-g>	Open with live_grep
telescope.load_extension('packer')
