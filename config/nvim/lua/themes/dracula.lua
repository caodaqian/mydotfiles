local status_ok, dracula = pcall(require, "dracula")
if not status_ok then
    return
end

vim.g.dracula_transparent_bg = true
vim.g.dracula_italic_comment = true
