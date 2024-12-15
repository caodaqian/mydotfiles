return {
	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.appearance.nert_font_variant = "default"
			opts.keymap = {
				preset = "super-tab",
				["<C-y>"] = { "select_and_accept" },
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"ai_accept",
					"fallback",
				},
				["<Enter>"] = {
					LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
					"fallback",
				},
			}
		end,
	},
}
