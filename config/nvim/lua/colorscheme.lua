local colorscheme_list = {"catppuccin", "dracula", "onedark", "github-nvim-theme"}

for i = 1, #colorscheme_list do
	local colorscheme = colorscheme_list[i]
	require("themes." .. colorscheme)

	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		vim.notify("colorscheme " .. colorscheme .. " not found!")
	else
		return
	end
end
