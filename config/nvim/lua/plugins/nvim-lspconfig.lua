return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ruff = { -- 这里定义 ruff 的初始化设置
					settings = {
						init_options = {
							settings = {
								-- 核心规则配置
								lint = {
									lint = {
										-- 启用 I001 (Isort 规则代码)
										select = { "I001", "E", "F", "W" },
										extendSelect = { "I" }, -- 确保 isort 类别被激活
									},
									ignore = {
										"E501", -- 忽略行长限制（通常交给 formatter）
										"B008", -- 允许在函数参数里写函数调用（在 FastAPI/Typer 中常见）
									},
									format = {
										-- 配置使用 Tab 缩进
										indentStyle = "tab",
									},
								},
								-- 指定一些具体的行为
								args = {
									"--line-length=140",
								},
							},
						},
					},
				},
			},
		},
	},
}
