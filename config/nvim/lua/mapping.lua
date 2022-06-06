local opts = {
	noremap = true,
	silent = true
}

local term_opts = {
	silent = true
}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
-- Modes normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t", command_mode = "c",

-- Remap space as leader key
local leader_key = " "
keymap("", leader_key, "<Nop>", opts)
vim.g.mapleader = leader_key
vim.g.maplocalleader = leader_key

-- Normal --
-- quick save or exit
keymap("n", "S", ":w<CR>", opts)
keymap("n", "Q", ":q<CR>", opts)
keymap("n", "QQ", ":wqa<cr>", opts)
keymap("n", "D", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)
keymap("n", "<C-q>", ":q!<CR>", opts)
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- better split
keymap("n", "sl", ":set nosplitright<CR>:vsplit<CR>", opts)
keymap("n", "sr", ":set splitright<CR>:vsplit<CR>", opts)
keymap("n", "su", ":set nosplitbelow<CR>:split<CR>", opts)
keymap("n", "sd", ":set splitbelow<CR>:split<CR>", opts)
-- move cursor
keymap("n", "H", "<home>", opts)
keymap("n", "L", "<end>", opts)
-- Resize with arrows
keymap("n", "<C-S-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-S-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-S-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-S-Right>", ":vertical resize -2<CR>", opts)
-- Navigate buffers
-- keymap("n", "R", ":bnext<CR>", opts)
-- keymap("n", "E", ":bprevious<CR>", opts)
-- NOTE: E/R navigation needs  'bufferline' plugin
keymap("n", "R", ":BufferLineCycleNext<CR>", opts)
keymap("n", "E", ":BufferLineCyclePrev<CR>", opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- nvim tree
keymap("n", "ff", "<cmd>NvimTreeToggle<CR>", opts)
-- hop
-- enhance f motion
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opts)
vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opts)
vim.api.nvim_set_keymap('n', '<leader><leader>w', "<cmd>HopWord<cr>", {})
vim.api.nvim_set_keymap('n', '<leader><leader>j', "<cmd>HopLine<cr>", {})
vim.api.nvim_set_keymap('n', '<leader><leader>k', "<cmd>HopLine<cr>", {})
-- dap debug keymap
keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint(); require'plugs.dap.dap-util'.store_breakpoints(true)<cr>", opts)
keymap('n', '<F10>', '<cmd>lua require"plugs.dap.dap-util".reload_continue()<CR>', opts)
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap('n', '<S-F5>', "<cmd>lua require'dap'.close()<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<S-F11>", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- require lsp
--keymap("n", "gR", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "=", "<cmd>Format<cr>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>dj", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
keymap("n", "<leader>dk", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap("n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap("n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Insert --
-- Press jj fast to enter
keymap("i", "jj", "<ESC>", opts)
-- move cursor
keymap("i", "<C-h>", "<left>", opts)
keymap("i", "<C-l>", "<right>", opts)
keymap("i", "<C-j>", "<down>", opts)
keymap("i", "<C-k>", "<up>", opts)
keymap("i", "<C-E>", "<C-right>", opts)
keymap("i", "<C-B>", "<C-left>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Navigate line
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- sudo then write ------------------------------------------------------------
vim.cmd [[
	cabbrev w!! w !sudo tee % >/dev/null
	cnoremap w!! w !sudo tee % >/dev/null
]]
