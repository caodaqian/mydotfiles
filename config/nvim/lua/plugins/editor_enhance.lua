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
	"tpope/vim-repeat",                        --  . command enhance
	{ "tpope/vim-surround", event = 'VeryLazy' }, -- vim surround
	"romainl/vim-cool",                        -- auto nohighlight on search
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
		config = function()
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL", })
			require('hlchunk').setup({
				chunk = {
					enable = true,
					use_treesitter = true,
				},
				indent = {
					chars = { "│", "¦", "┆", "┊", },
					use_treesitter = true,
				},
				blank = {
					enable = false,
				},
				line_num = {
					enable = true,
					use_treesitter = true,
				},
			})
		end
	},
	"norcalli/nvim-colorizer.lua", -- show color
	"sindrets/winshift.nvim",   -- rerange window layout
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
	}
}
