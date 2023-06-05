return {
	cmd = { "gopls" },
	root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}
