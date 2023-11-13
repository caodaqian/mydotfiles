return {
	{
		"ethanholz/nvim-lastplace", -- auto return back to the last modified positon when open a file
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = false,
		},
	},
	"nvim-pack/nvim-spectre",                  -- search and replace pane
	{ "tpope/vim-repeat",   event = "VeryLazy" }, --  . command enhance
	{ "tpope/vim-surround", event = "VeryLazy" }, -- vim surround
	{ "romainl/vim-cool",   event = "VeryLazy" }, -- auto nohighlight on search
	{
		"numToStr/Comment.nvim",               -- quick comment code
		event = "BufRead",
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
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		init = function()
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })
		end,
		config = function()
			local support_filetypes = vim.tbl_deep_extend("force", require('hlchunk.utils.filetype').support_filetypes, {})
			local exclude_filetypes = vim.tbl_deep_extend("force", require('hlchunk.utils.filetype').exclude_filetypes, {
				['dap-repl'] = true,
				dapui_scopes = true,
				dapui_breakpoints = true,
				dapui_stacks = true,
			})
			require("hlchunk").setup({
				chunk = {
					support_filetypes = support_filetypes,
					exclude_filetypes = exclude_filetypes,
				},
				indent = {
					enable = true,
					chars = { "│", "¦", "┆", "┊" },
					use_treesitter = false,
				},
				blank = {
					enable = false,
				},
				line_num = {
					enable = true,
					use_treesitter = true,
				},
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua", -- show color
		event = "UIEnter",
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",       -- Highlight all files, but customize some others.
					css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
					html = { names = false }, -- Disable parsing "names" like Blue or Gray
				},
			})
		end,
	},
	{
		"sindrets/winshift.nvim", -- rerange window layout
		event = "WinNew",
	},
	{
		"RRethy/vim-illuminate", -- highlight undercursor word
		event = { "CursorMovedI", "CursorMoved" },
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
		ft = { "gitcommit", "diff" },
		keys = {
			{
				"]c",
				function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						require("gitsigns").next_hunk()
					end)
					return "<Ignore>"
				end,
				desc = "Jump to next hunk",
			},
			{
				"[c",
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						require("gitsigns").prev_hunk()
					end)
					return "<Ignore>"
				end,
				desc = "Jump to prev hunk",
			},
			{
				"<leader>rh",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Reset hunk",
			},
			{
				"<leader>ph",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview hunk",
			},
			{
				"<leader>td",
				function()
					require("gitsigns").toggle_deleted()
				end,
				desc = "Toggle deleted",
			},
		},
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		config = function()
			require("gitsigns").setup({
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				current_line_blame = true,
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
			})
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
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
		},
	},
	{
		"nyngwang/NeoZoom.lua",
		event = "WinNew",
		keys = {
			{
				"<leader>z",
				function()
					vim.cmd("NeoZoomToggle")
				end,
				desc = "open zoom window",
			},
		},
		config = function()
			require("neo-zoom").setup({
				exclude_buftypes = { "terminal" },
				exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },
				winopts = {
					offset = {
						-- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
						-- top = 0,
						-- left = 0.17,
						width = 0.9,
						height = 0.85,
					},
				},
			})
		end,
	},
}
