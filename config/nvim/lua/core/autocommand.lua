local function augroup(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_doc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"vim",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end
})

-- do not auto comment new line
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o"
})

-- check spell on gitcommit
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("check_spell_gitcommit"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.wrap = true
	end
})

vim.api.nvim_create_user_command("Format", function(input)
	vim.lsp.buf.format()
end, { desc = "format this buffer" })

