local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

if colorscheme == "onedark" then
    require "themes.onedark"
elseif colorscheme == "catppuccin" then
    require "themes.catppuccin"
elseif colorscheme == "dracula" then
    require "themes.dracula"
elseif colorscheme == "github-nvim-theme" then
    require "themes.github-nvim-theme"
end
