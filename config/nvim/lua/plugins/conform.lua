return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				-- 对 python 文件顺序执行 ruff_organize_imports 和 ruff_format
				python = { "ruff_organize_imports", "ruff_format" },
			},
		},
	},
}
