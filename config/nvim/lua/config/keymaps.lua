-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n" }, "D", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Close this buffer" })

vim.keymap.set({ "n", "i" }, "<A-p>", "<cmd>pu<cr>", { desc = "Paste on next line" })

vim.keymap.set({ "n", "v" }, "<leader>z", "<C-W><C-\\|><C-W><C-_>", { desc = "Zoom one pane" })

vim.keymap.set({ "i" }, "jj", "<ESC>", { desc = "Turn to Normar Mode" })
