-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n" }, "D", "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Close this buffer", silent = true })
vim.keymap.set({ "n" }, "<C-q>", "<cmd>q<cr>", { desc = "Close this window", silent = true })
-- Resize window using <Shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.keymap.set({ "n", "i" }, "<A-p>", "<cmd>pu<cr>", { desc = "Paste on next line" })

vim.keymap.set({ "n", "v" }, "<leader>z", "<C-W><C-\\|><C-W><C-_>", { desc = "Zoom one pane" })

vim.keymap.set({ "i" }, "jj", "<ESC>", { desc = "Turn to Normar Mode" })
vim.keymap.set({ "i" }, "<C-l>", "<Right>", { desc = "Move cursor right" })
vim.keymap.set({ "i" }, "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set({ "i" }, "<C-j>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set({ "i" }, "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set({ "i" }, "<S-enter>", "<C-O>O", { desc = "Prev line" })
vim.keymap.set({ "i" }, "<C-enter>", "<C-O>o", { desc = "Next line" })
vim.keymap.set({ "i" }, "<C-.>", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "i" }, "<m-l>", "<C-o>%", { desc = "Move cursor next brackets" })
vim.keymap.set({ "i" }, "<m-h>", "<C-o>%", { desc = "Move cursor next brackets" })

-- debug
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "Continue" })
vim.keymap.set("n", "<F17>", function()
	require("dap").terminate()
end, { desc = "Terminate" })
vim.keymap.set("n", "<F22>", function()
	require("dap").run_to_cursor()
end, { desc = "Run to cursor" })
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "Step over" })
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "Step into" })
vim.keymap.set("n", "<F23>", function()
	require("dap").step_out()
end, { desc = "Step out" })
vim.keymap.set("n", "<F9>", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<F21>", function()
	require("dap").set_breakpoint()
end, { desc = "Set breakpoint" })
