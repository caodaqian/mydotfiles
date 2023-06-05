require "options"
require "mapping"
require "autocommand"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = {import = "plugins"},
})

-- set colorscheme
local colorscheme_list = {"catppuccin", "dracula", "onedark"}
for i = 1, #colorscheme_list do
	local colorscheme = colorscheme_list[i]
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		vim.notify("colorscheme " .. colorscheme .. " not found!")
	else
		return
	end
end
