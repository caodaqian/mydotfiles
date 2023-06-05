return {
	"karb94/neoscroll.nvim", -- smart scroll
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
			local hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = { error = " ", warn = " " },
				colored = false,
				update_in_insert = false,
				always_visible = true,
			}

			local diff = {
				"diff",
				colored = true,
				symbols = { added = "  ", modified = " ", removed = " " },
				diff_color = {
					added = { fg = "#98be65" },
					modified = { fg = "#ecbe7b" },
					removed = { fg = "#ec5f67" },
				},
				cond = hide_in_width,
			}

			local mode = {
				"mode",
				fmt = function(str)
					return "-- " .. str .. " --"
				end,
			}

			local file_name = {
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				path = 2, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
				},
			}

			local filetype = {
				"filetype",
				icons_enabled = false,
				icon = nil,
			}

			local branch = {
				"branch",
				icons_enabled = true,
				icon = "",
			}

			local location = {
				"location",
				padding = 0,
			}

			-- cool function for progress
			local progress = function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				-- local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
				local chars = { "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", " " }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end

			local spaces = function()
				return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
			end
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { branch, diagnostics },
					lualine_b = { mode },
					lualine_c = {
						file_name,
						{ require("nvim-gps").get_location, cond = require("nvim-gps").is_available },
					},
					lualine_x = { diff, spaces, "encoding", filetype, "fileformat" },
					lualine_y = { location },
					lualine_z = { progress },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { file_name },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
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
