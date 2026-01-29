return {
	"mfussenegger/nvim-lint",
	optional = true,
	opts = {
		linters = {
			["markdownlint-cli2"] = {
				prepend_args = {
					"--config",
					os.getenv("HOME") .. "/.config/formatter/markdownlint-cli2.jsonc",
					"--",
				},
			},
		},
	},
}
