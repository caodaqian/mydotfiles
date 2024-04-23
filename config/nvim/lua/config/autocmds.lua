-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- sudo then write
vim.cmd([[
	cabbrev w!! w !sudo tee % >/dev/null
	cnoremap w!! w !sudo tee % >/dev/null
]])

vim.api.nvim_create_user_command("Format", function(input)
	vim.lsp.buf.format()
end, { desc = "format this buffer" })
