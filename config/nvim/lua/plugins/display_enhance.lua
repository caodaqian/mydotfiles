return {
	"karb94/neoscroll.nvim",   -- smart scroll
	"haringsrob/nvim_context_vt", -- show if, for, function... end as virtual text
	{
		"akinsho/bufferline.nvim", -- tab
		lazy = false,
		config = function()
			require("bufferline").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim", -- status line
		dependencies = {
			"SmiteshP/nvim-gps",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = { 'filename',
						{ require("nvim-gps").get_location, cond = require("nvim-gps").is_available }, },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'mode' },
					lualine_x = { 'spaces' },
					lualine_y = { 'filesize', 'fileformat', 'filetype' },
					lualine_z = { 'location' }
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'file_name' },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinNew" },
	},
	-- {
	-- 	"Bekaboo/dropbar.nvim",
	-- 	config = function()
	-- 		local api = require("dropbar.api")
	-- 		vim.keymap.set('n', '<Leader>;', api.pick)
	-- 		vim.keymap.set('n', '[c', api.goto_context_start)
	-- 		vim.keymap.set('n', ']c', api.select_next_context)
	--
	-- 		local confirm = function()
	-- 			local menu = api.get_current_dropbar_menu()
	-- 			if not menu then
	-- 				return
	-- 			end
	-- 			local cursor = vim.api.nvim_win_get_cursor(menu.win)
	-- 			local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
	-- 			if component then
	-- 				menu:click_on(component)
	-- 			end
	-- 		end
	--
	-- 		local quit_curr = function()
	-- 			local menu = api.get_current_dropbar_menu()
	-- 			if menu then
	-- 				menu:close()
	-- 			end
	-- 		end
	--
	-- 		require("dropbar").setup({
	-- 			menu = {
	-- 				-- When on, automatically set the cursor to the closest previous/next
	-- 				-- clickable component in the direction of cursor movement on CursorMoved
	-- 				quick_navigation = true,
	-- 				---@type table<string, string|function|table<string, string|function>>
	-- 				keymaps = {
	-- 					['<LeftMouse>'] = function()
	-- 						local menu = api.get_current_dropbar_menu()
	-- 						if not menu then
	-- 							return
	-- 						end
	-- 						local mouse = vim.fn.getmousepos()
	-- 						if mouse.winid ~= menu.win then
	-- 							local parent_menu = api.get_dropbar_menu(mouse.winid)
	-- 							if parent_menu and parent_menu.sub_menu then
	-- 								parent_menu.sub_menu:close()
	-- 							end
	-- 							if vim.api.nvim_win_is_valid(mouse.winid) then
	-- 								vim.api.nvim_set_current_win(mouse.winid)
	-- 							end
	-- 							return
	-- 						end
	-- 						menu:click_at({ mouse.line, mouse.column }, nil, 1, 'l')
	-- 					end,
	-- 					['<CR>'] = confirm,
	-- 					['i'] = confirm,
	-- 					['<esc>'] = quit_curr,
	-- 					['q'] = quit_curr,
	-- 					['n'] = quit_curr,
	-- 					['<MouseMove>'] = function()
	-- 						local menu = api.get_current_dropbar_menu()
	-- 						if not menu then
	-- 							return
	-- 						end
	-- 						local mouse = vim.fn.getmousepos()
	-- 						if mouse.winid ~= menu.win then
	-- 							return
	-- 						end
	-- 						menu:update_hover_hl({ mouse.line, mouse.column - 1 })
	-- 					end,
	-- 				},
	-- 			},
	-- 		})
	-- 	end
	-- },
	{
		"folke/todo-comments.nvim", -- highlight todo commments
		opts = {
			keywords = {
				-- alt ： 别名
				FIX = {
					icon = " ",
					color = "#DC2626",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "!" },
				},
				TODO = { icon = " ", color = "#2563EB" },
				HACK = { icon = " ", color = "#7C3AED" },
				WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", color = "#FC9868", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "#10B981", alt = { "INFO" } },
			},
		},
	},
	"mtdl9/vim-log-highlighting",
	{
		"goolord/alpha-nvim", -- welcome page
		lazy = false,
		keys = {
			{ "<leader>w", "<cmd>Alpha<cr>", desc = "welcome page" },
		},
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				[[                                                 ]],
				[[                               __                ]],
				[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
				[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
				[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
				[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
				[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
				[[                                                 ]],
			}
			dashboard.section.buttons.val = {
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("F", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("l", "  File brower", ":Lf<CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
				dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
			}

			local function footer()
				-- NOTE: requires the fortune-mod package to work
				-- local handle = io.popen("fortune")
				-- local fortune = handle:read("*a")
				-- handle:close()
				-- return fortune
				return os.getenv("USER")
			end

			dashboard.section.footer.val = footer()

			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "Include"
			dashboard.section.buttons.opts.hl = "Keyword"

			dashboard.opts.opts.noautocmd = true
			require("alpha").setup(dashboard.opts)
		end,
	},
}
