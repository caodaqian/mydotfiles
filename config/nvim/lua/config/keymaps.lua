-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n" }, "D", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Close this buffer" })

vim.keymap.set({ "n", "i" }, "<A-p>", "<cmd>pu<cr>", { desc = "Paste on next line" })

vim.keymap.set({ "n", "v" }, "<leader>z", "<C-W><C-\\|><C-W><C-_>", { desc = "Zoom one pane" })

vim.keymap.set({ "i" }, "jj", "<ESC>", { desc = "Turn to Normar Mode" })
vim.keymap.set({ "i" }, "<C-l>", "<Right>", { desc = "Move cursor right" })
vim.keymap.set({ "i" }, "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set({ "i" }, "<C-j>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set({ "i" }, "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set({ "i" }, "<m-l>", "<C-o>%", { desc = "Move cursor next brackets" })
vim.keymap.set({ "i" }, "<m-h>", "<C-o>%", { desc = "Move cursor next brackets" })
