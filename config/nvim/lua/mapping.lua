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
-- Better window navigation
keymap("i", "<C-h>", "<C-w>h", opts)
keymap("i", "<C-j>", "<C-w>j", opts)
keymap("i", "<C-k>", "<C-w>k", opts)
keymap("i", "<C-l>", "<C-w>l", opts)

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

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- sudo then write ------------------------------------------------------------
vim.cmd [[
cabbrev w!! w !sudo tee % >/dev/null
cnoremap w!! w !sudo tee % >/dev/null
]]
