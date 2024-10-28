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

-- Disable automatic commenting on newline
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	pattern = "*",
	callback = function()
		-- vim.opt_local.formatoptions:remove("c")
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
	end,
})
