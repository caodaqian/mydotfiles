return {
	{
		"akinsho/bufferline.nvim", -- tab
		dependencies = "nvim-tree/nvim-web-devicons",
		lazy = false,
		keys = {
			{ "<leader>gb", "<cmd>BufferLinePick<CR>", desc = "switch buffer" },
			{ "<leader>gx", "<cmd>BufferLinePickClose<CR>", desc = "close buffer" },
		},
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "buffer_id",
					max_name_length = 25,
					max_prefix_length = 20, -- prefix used when a buffer is de-duplicated
					truncate_names = true, -- whether or not tab names should be truncated
					diagnostics = "nvim_lsp",
					enforce_regular_tabs = true,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim", -- status line
		lazy = false,
		dependencies = {
			"lewis6991/gitsigns.nvim", -- git signs
		},
		config = function()
			local hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end

			local mode = {
				"mode",
				fmt = function(str)
					return " " .. str
				end,
			}

			local filetype = {
				"filetype",
				icons_enabled = true,
				icon = nil,
			}

			local filename = {
				"filename",
				icons_enabled = true,
				icon = "󰈚",
			}

			local branch = {
				"branch",
				icons_enabled = true,
				icon = "",
			}
			local diff = {
				"diff",
				colored = true,
				symbols = { added = "  ", modified = "  ", removed = "  " }, -- changes diff symbols
				cond = hide_in_width,
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed,
						}
					end
				end,
			}

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn", "hints", "info" },
				symbols = { error = " ", warn = " ", hints = "󰛩 ", info = "󰋼 " },
				colored = true,
				update_in_insert = false,
				always_visible = false,
			}

			local location = {
				function()
					local current_line = vim.fn.line(".")
					local total_lines = vim.fn.line("$")
					-- local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
					local chars =
						{ "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", "__" }
					local line_ratio = current_line / total_lines
					local line_percentage = math.ceil(line_ratio * 100)
					local index = math.ceil(line_ratio * #chars)
					local line_progress = chars[index]
					return current_line .. ":" .. vim.fn.col(".") .. " " .. line_percentage .. "%%" .. line_progress
				end,
				icons_enabled = true,
				icon = " ",
			}

			local cwd = {
				function()
					return (vim.o.columns > 85 and (vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))) or ""
				end,
				icons_enabled = true,
				icon = "󰉋",
			}

			local spaces = function()
				return "->|" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
			end

			local lsp_progress = {
				function()
					if not rawget(vim, "lsp") or vim.lsp.status then
						return ""
					end

					local Lsp = vim.lsp.util.get_progress_messages()[1]

					if vim.o.columns < 120 or not Lsp then
						return ""
					end

					local msg = Lsp.message or ""
					local percentage = Lsp.percentage or 0
					local title = Lsp.title or ""
					local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
					local ms = vim.loop.hrtime() / 1000000
					local frame = math.floor(ms / 120) % #spinners
					local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

					return ("%#St_LspProgress#" .. content) or ""
				end,
			}

			local lsp_status = {
				function()
					if rawget(vim, "lsp") then
						for _, client in ipairs(vim.lsp.get_active_clients()) do
							if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
								return "LSP~" .. client.name
							end
						end
					end
				end,
				icons_enabled = true,
				icon = " ",
			}

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					disabled_filetypes = {
						"alpha",
						"dashboard",
						"NvimTree",
						"Outline",
						"TelescopePrompt",
						"packer",
						"DressingInput",
						"toggleterm",
						"lazy",
					},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						mode,
					},
					lualine_b = {
						filetype,
						filename,
					},
					lualine_c = { branch, diff, "selectioncount" },
					lualine_x = { lsp_progress, "encoding", spaces, diagnostics },
					lualine_y = { lsp_status, cwd },
					lualine_z = { location },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { filename },
					lualine_x = { location },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {
					"fzf",
					"lazy",
					"nvim-dap-ui",
					"nvim-tree",
					"toggleterm",
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
		event = "BufRead",
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
	{ "mtdl9/vim-log-highlighting", event = "BufRead" },
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
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("F", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("l", "  File brower", ":Lf<CR>"),
				dashboard.button("r", "↻  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
				dashboard.button("q", "⁐  Quit Neovim", ":qa<CR>"),
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
