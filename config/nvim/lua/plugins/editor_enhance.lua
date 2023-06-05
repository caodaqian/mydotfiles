return {
	{
		"ethanholz/nvim-lastplace", -- auto return back to the last modified positon when open a file
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = false,
		},
	},
	"nvim-pack/nvim-spectre", -- search and replace pane
	"tpope/vim-repeat", --  . command enhance
	"tpope/vim-surround", -- vim surround
	"romainl/vim-cool", -- auto nohighlight on search
	{
		"numToStr/Comment.nvim", -- quick comment code
		event = "BufRead",
		config = true,
	},
	{
		"phaazon/hop.nvim", -- like easymotion, but more powerful
		event = "BufRead",
		init = function()
			local opts = {
				noremap = true,
				silent = true,
			}
			-- enhance f motion
			vim.api.nvim_set_keymap(
				"n",
				"f",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.AFTER_CURSOR, current_line_only = true })<cr>",
				opts
			)
			vim.api.nvim_set_keymap(
				"n",
				"F",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.BEFORE_CURSOR, current_line_only = true })<cr>",
				opts
			)
			vim.api.nvim_set_keymap(
				"o",
				"f",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
				opts
			)
			vim.api.nvim_set_keymap(
				"o",
				"F",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
				opts
			)
			vim.api.nvim_set_keymap("n", "<leader><leader>w", "<cmd>HopWord<cr>", {})
			vim.api.nvim_set_keymap("n", "<leader><leader>j", "<cmd>HopLine<cr>", {})
			vim.api.nvim_set_keymap("n", "<leader><leader>k", "<cmd>HopLine<cr>", {})
		end,
		config = true,
	},
	{
		"akinsho/toggleterm.nvim", -- toggle terminal
		lazy = false,
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "open float term" },
		},
		opts = {
			direction = "float",
		},
		init = function()
			vim.api.nvim_set_keymap("n", "<c-\\>", "<cmd>exe v:count1 . 'ToggleTerm'<CR>", { silent = true })
			vim.api.nvim_set_keymap("i", "<c-\\>", "<cmd>exe v:count1 . 'ToggleTerm'<CR>", { silent = true })
			vim.api.nvim_create_autocmd("TermEnter", {
				pattern = "term://*toggleterm#*",
				callback = function()
					vim.api.nvim_set_keymap("t", "<c-\\>", "<cmd>exe v:count1 . 'ToggleTerm'<CR>", { silent = true })
				end,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim", -- indent blankline
		init = function()
			vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
			vim.g.indent_blankline_filetype_exclude =
				{ "help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree", "Trouble" }
			vim.g.indentLine_enabled = 1
			-- vim.g.indent_blankline_char = "│"
			--vim.g.indent_blankline_char = "▏"
			-- vim.g.indent_blankline_char = "▎"
			vim.g.indent_blankline_show_first_indent_level = false
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_use_treesitter = true
			vim.g.indent_blankline_show_current_context = true
			vim.g.indent_blankline_context_patterns = {
				"class",
				"return",
				"function",
				"method",
				"^if",
				"^while",
				"jsx_element",
				"^for",
				"^object",
				"^table",
				"block",
				"arguments",
				"if_statement",
				"else_clause",
				"jsx_element",
				"jsx_self_closing_element",
				"try_statement",
				"catch_clause",
				"import_statement",
				"operation_type",
			}

			vim.g.indentLine_concealcursor = "inc"
			vim.g.indentLine_conceallevel = 2
			vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
			--vim.opt.list = true
			--vim.opt.listchars:append "space:⋅"
			--vim.opt.listchars:append "eol:↴"
		end,
	},
	"norcalli/nvim-colorizer.lua", -- show color
	"sindrets/winshift.nvim", -- rerange window layout
	{
		"RRethy/vim-illuminate", -- highlight undercursor word
		init = function()
			vim.g.Illuminate_ftblacklist = {
				"NvimTree",
				"vista_kind",
				"toggleterm",
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim", -- git signs
		event = { "CursorMoved", "CursorMovedI" },
	},
	{
		"voldikss/vim-translator",
		init = function()
			vim.g.translator_target_lang = "zh"
			vim.g.translator_default_engines = { "bing", "youdao" }
		end,
	},
	{
		"numToStr/Navigator.nvim",
		lazy = false,
		init = function()
			vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
			vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
			vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
			vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
			vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")
		end,
		config = true,
	},
}
