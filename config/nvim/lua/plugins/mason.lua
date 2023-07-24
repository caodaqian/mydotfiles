return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		priority = 950,
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		priority = 940,
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig", -- enable LSP
			{ "folke/neodev.nvim", ft = {"lua"} }
		},
		config = function()
			require("neodev").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", },
				automatic_installation = true,
			})
			require("mason-lspconfig").setup_handlers {
				function (server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {}
				end,
				["rust_analyzer"] = function ()
					require("rust-tools").setup {}
				end,
				["lua_ls"] = function ()
					require('lspconfig').lua_ls.setup {
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.stdpath("config") .. "/lua"] = true,
									},
								},
							}
						}
					}
				end,
				['pyright'] = function ()
					require('lspconfig').pyright.setup {
						cmd = { 'pyright-langserver', '--stdio', '--lib', '--skipunannotated' },
						settings = {
							python = {
								analysis = {
									autoImportCompletions = true,
									autoSearchPaths = true,
									useLibraryCodeForTypes = true,
									diagnosticMode = "workspace",
									diagnosticSeverityOverrides = "none",
									-- typeCheckingMode = "off",
								}
							},
							pyright = {
								reportGeneralTypeIssues = "none",
								reportPropertyTypeMismatch = "info",
								reportFunctionMemberAccess = "info",
								reportMissingTypeStubs = "info",
								reportUnknownMemberType = "info",
								disableLanguageServices = false,
								disableOrganizeImports = false,
							}
						}
					}
				end,
				['gopls'] = function ()
					require('lspconfig').gopls.setup {
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
				end
			}
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = false,
		priority = 940,
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			automatic_setup = true,
		},
		config = function()
			local function config_debuggers()
				local dap = require("dap")
				dap.defaults.fallback.terminal_win_cmd = "50vsplit new" -- this will be overrided by dapui
				-- show the debug console
				dap.defaults.fallback.console = "internalConsole"
			end

			config_debuggers() -- Debugger
			require("mason-nvim-dap").setup({
				handlers = {
					function(config)
						-- all sources with no handler get passed here
						-- Keep original functionality
						config_debuggers() -- Debugger
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
}
