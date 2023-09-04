return {
	{
		"hrsh7th/nvim-cmp", -- The completion plugin
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-path", -- path completions
			"hrsh7th/cmp-cmdline", -- cmdline completions
			"petertriho/cmp-git", -- git completions
			"saadparwaiz1/cmp_luasnip", -- snippet completions
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-calc",
			"f3fora/cmp-spell", -- spell check
			"ray-x/cmp-treesitter",
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)

					-- vscode format
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

					-- snipmate format
					require("luasnip.loaders.from_snipmate").load()
					require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

					-- lua format
					require("luasnip.loaders.from_lua").load()
					require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

					vim.api.nvim_create_autocmd("InsertLeave", {
						callback = function()
							if
								require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
								and not require("luasnip").session.jump_active
							then
								require("luasnip").unlink_current()
							end
						end,
					})
				end,
			},
			{
				"onsails/lspkind.nvim",
				lazy = false,
				config = function()
					require("lspkind").init()
				end,
			},
		},
		config = function()
			local function has_words_before()
				local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local limitStr = function(str)
				if #str > 25 then
					str = string.sub(str, 1, 22) .. "..."
				end
				return str
			end

			---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
			---@param dir number 1 for forward, -1 for backward; defaults to 1
			---@return boolean true if a jumpable luasnip field is found while inside a snippet
			local function jumpable(dir)
				local luasnip_ok, luasnip = pcall(require, "luasnip")
				if not luasnip_ok then
					return false
				end

				local win_get_cursor = vim.api.nvim_win_get_cursor
				local get_current_buf = vim.api.nvim_get_current_buf

				local function inside_snippet()
					-- for outdated versions of luasnip
					if not luasnip.session.current_nodes then
						return false
					end

					local node = luasnip.session.current_nodes[get_current_buf()]
					if not node then
						return false
					end

					local snip_begin_pos, snip_end_pos = node.parent.snippet.mark:pos_begin_end()
					local pos = win_get_cursor(0)
					pos[1] = pos[1] - 1 -- LuaSnip is 0-based not 1-based like nvim for rows
					return pos[1] >= snip_begin_pos[1] and pos[1] <= snip_end_pos[1]
				end

				---sets the current buffer's luasnip to the one nearest the cursor
				---@return boolean true if a node is found, false otherwise
				local function seek_luasnip_cursor_node()
					-- for outdated versions of luasnip
					if not luasnip.session.current_nodes then
						return false
					end

					local pos = win_get_cursor(0)
					pos[1] = pos[1] - 1
					local node = luasnip.session.current_nodes[get_current_buf()]
					if not node then
						return false
					end

					local snippet = node.parent.snippet
					local exit_node = snippet.insert_nodes[0]

					-- exit early if we're past the exit node
					if exit_node then
						local exit_pos_end = exit_node.mark:pos_end()
						if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
							snippet:remove_from_jumplist()
							luasnip.session.current_nodes[get_current_buf()] = nil

							return false
						end
					end

					node = snippet.inner_first:jump_into(1, true)
					while node ~= nil and node.next ~= nil and node ~= snippet do
						local n_next = node.next
						local next_pos = n_next and n_next.mark:pos_begin()
						local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
							or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

						-- Past unmarked exit node, exit early
						if n_next == nil or n_next == snippet.next then
							snippet:remove_from_jumplist()
							luasnip.session.current_nodes[get_current_buf()] = nil

							return false
						end

						if candidate then
							luasnip.session.current_nodes[get_current_buf()] = node
							return true
						end

						local ok
						ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
						if not ok then
							snippet:remove_from_jumplist()
							luasnip.session.current_nodes[get_current_buf()] = nil

							return false
						end
					end

					-- No candidate, but have an exit node
					if exit_node then
						-- to jump to the exit node, seek to snippet
						luasnip.session.current_nodes[get_current_buf()] = snippet
						return true
					end

					-- No exit node, exit from snippet
					snippet:remove_from_jumplist()
					luasnip.session.current_nodes[get_current_buf()] = nil
					return false
				end

				if dir == -1 then
					return inside_snippet() and luasnip.jumpable(-1)
				else
					return inside_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable()
				end
			end

			local status_cmp_ok, cmp = pcall(require, "cmp")
			if not status_cmp_ok then
				return
			end
			local status_luasnip_ok, luasnip = pcall(require, "luasnip")
			if not status_luasnip_ok then
				return
			end

			require("luasnip.loaders.from_vscode").lazy_load() -- load freindly-snippets
			require("luasnip.loaders.from_vscode").load({
				paths = { -- load custom snippets
					vim.fn.stdpath("config") .. "/my-snippets",
				},
			}) -- Load snippets from my-snippets folder

			cmp_config = {
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				completion = {
					completeopt = "menu,menuone",
					---@usage The minimum length of a word to complete on.
					keyword_length = 2,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					duplicates = {
						buffer = 1,
						path = 1,
						nvim_lsp = 0,
						luasnip = 1,
					},
					duplicates_default = 0,
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							symbol_map = { Codeium = "" },
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = limitStr(entry:get_completion_item().detail or "")
						kind.dup = cmp_config.formatting.duplicates[entry.source.name]
							or cmp_config.formatting.duplicates_default
						return kind
					end,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
						scrollbar = false,
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "cmp_tabnine" },
					{ name = "nvim_lua" },
					{ name = "buffer" },
					{ name = "spell" },
					{ name = "calc" },
					{ name = "emoji" },
					{ name = "treesitter" },
					{ name = "crates" },
					{ name = "nvim_lsp_signture_help" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
							elseif has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end,
					}),
					["<S-Tab>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
							else
								fallback()
							end
						end,
					}),
					["<C-p>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.confirm(cmp_config.confirm_opts) then
							if jumpable(1) then
								luasnip.jump(1)
							end
							return
						end

						if jumpable(1) then
							if not luasnip.jump(1) then
								fallback()
							end
						else
							fallback()
						end
					end),
				}),
				experimental = {
					ghost_text = true,
				},
			}
			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline("?", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline" },
				}, {
					{ name = "path" },
				}),
			})
			-- disable autocompletion for guihua
			vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
			vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")

			cmp.setup(cmp_config)
		end,
	},
	{
		"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
		lazy = false,
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			-- You can use treesitter to check for a pair.
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			npairs.setup({
				check_ts = true,
				enable_check_bracket_line = false,
				fast_wrap = {},
				disable_filetype = { "telescopeprompt", "vim" },
				ts_config = {
					lua = { "string" }, -- it will not add a pair on that treesitter node
					javascript = { "template_string" },
					java = false, -- don't check treesitter on java
				},
			})
			local ts_conds = require("nvim-autopairs.ts-conds")
			-- press % => %% only while inside a comment or string
			npairs.add_rules({
				Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
				Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
			})

			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
