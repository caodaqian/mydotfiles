return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"supermaven-inc/supermaven-nvim",
		},
		opts = function(_, opts)
			-- better humanful keymapping
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")
			local suggestion = require("supermaven-nvim.completion_preview")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-e>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.abort()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i" }),
				["<C-g>"] = function()
					if cmp.visible_docs() then
						cmp.close_docs()
					else
						cmp.open_docs()
					end
				end,
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					elseif suggestion.has_suggestion() then
						suggestion.on_accept_suggestion_word()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					elseif suggestion.has_suggestion() then
						suggestion.on_accept_suggestion_word()
					else
						fallback()
					end
				end, { "i", "s" }),
			})

			-- fix cmp select
			opts.preselect = cmp.PreselectMode.None
			opts.completion = { completeopt = "menu,menuone,noselect" }

			-- add ai supermaven cmp
			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "supermaven" } }))
		end,
	},
}
