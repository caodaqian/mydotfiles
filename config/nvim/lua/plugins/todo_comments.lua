return {
	{
		"folke/todo-comments.nvim",
		opts = {
			highlight = {
				pattern = [[\s+<(KEYWORDS)\s+]],
			},
			search = {
				pattern = [[\b(KEYWORDS)\b]],
			},
		},
	},
}
