return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-null-ls").setup({
				ensure_installed = { "black", "goimports_reviser", "golines", "isort", "jq", "sql_formatter", "stylua", "gofumpt", "mypy" },
				automatic_installation = true,
				handlers = {},
			})
		end,
	}
}
