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
				ensure_installed = { "black", "fixjson", "goimports_reviser", "golines", "isort", "jq", "pylint", "sql_formatter", "stylua" },
				automatic_installation = true,
				handlers = {},
			})
		end,
	}
}
