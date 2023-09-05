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
					str = string.sub(str, 1, 23) .. ".."
				end
				return str
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
					{ name = "nvim_lua" },
					{ name = "buffer" },
					{ name = "spell" },
					{ name = "calc" },
					{ name = "treesitter" },
					{ name = "crates" },
					{ name = "nvim_lsp_signture_help" },
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local cnt = 1
							if cmp.get_active_entry() == nil then
								cnt = 0
							end
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert, count = cnt })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local cnt = 1
							if cmp.get_active_entry() == nil then
								cnt = 0
							end
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert, count = cnt })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end),
					["<C-p>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				experimental = {
					ghost_text = true,
				},
			}
			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				mapping = cmp_config.mapping,
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline("?", {
				mapping = cmp_config.mapping,
				sources = { { name = "buffer" } },
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp_config.mapping,
				sources = {
					{ name = "cmdline" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "spell" },
				},
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
