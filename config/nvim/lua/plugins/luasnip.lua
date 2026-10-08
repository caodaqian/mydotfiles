return {
	{
		"L3MON4D3/LuaSnip",
		opts = function()
			-- 修复 snippet_forward：更严格的判断
			LazyVim.cmp.actions.snippet_forward = function()
				local luasnip = require("luasnip")
				if luasnip.jumpable(1) then
					vim.schedule(function()
						luasnip.jump(1)
					end)
					return true
				end
				return false
			end
			-- 修复 snippet_stop：更宽松的取消条件
			LazyVim.cmp.actions.snippet_stop = function()
				local luasnip = require("luasnip")
				-- 不再依赖 expand_or_jumpable()，而是直接检查是否存在 session
				if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] then
					luasnip.unlink_current()
					return true
				end
				return false
			end
			return {
				history = true,
				delete_check_events = "TextChanged",
				region_check_events = {
					"CursorMoved",
					"CursorMovedI",
					"CursorHold",
					"CursorHoldI",
					"InsertLeave",
					"ModeChanged",
				},
			}
		end,
	},
}
