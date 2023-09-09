-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = {
	noremap = true,
	silent = true,
}

-- Remap space as leader key
local leader_key = " "
keymap("", leader_key, "<Nop>", opts)
vim.g.mapleader = leader_key
vim.g.maplocalleader = leader_key

-- Modes normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t", command_mode = "c",
local mode_nv = { "n", "v" }
local mode_ni = { "n", "i" }
local mode_nvo = { "n", "v", "o" }
local mode_v = { "v" }
local mode_i = { "i" }
local mode_n = { "n" }

local mappings = {
	-- Normal --
	-- quick save or exit
	{ from = "<C-s>", to = ":w<CR>", mode = mode_nvo },
	{ from = "Q", to = ":q<CR>", mode = mode_n },
	{ from = "D", to = ":bp<bar>sp<bar>bn<bar>bd<CR>", mode = mode_n },
	{ from = "<C-q>", to = ":q!<CR>", mode = mode_n },
	-- Better window navigation
	{ from = "<C-h>", to = "<C-w>h", mode = mode_n },
	{ from = "<C-j>", to = "<C-w>j", mode = mode_n },
	{ from = "<C-k>", to = "<C-w>k", mode = mode_n },
	{ from = "<C-l>", to = "<C-w>l", mode = mode_n },
	-- better split
	{ from = "sl", to = ":set nosplitright<CR>:vsplit<CR>", mode = mode_n },
	{ from = "sr", to = ":set splitright<CR>:vsplit<CR>", mode = mode_n },
	{ from = "su", to = ":set nosplitbelow<CR>:split<CR>", mode = mode_n },
	{ from = "sd", to = ":set splitbelow<CR>:split<CR>", mode = mode_n },
	-- move cursor
	{ from = "H", to = "<home>", mode = mode_nvo },
	{ from = "L", to = "<end>", mode = mode_nvo },
	-- Resize with arrows
	{ from = "<S-Up>", to = ":resize -1<CR>", mode = mode_n },
	{ from = "<S-Down>", to = ":resize +2<CR>", mode = mode_n },
	{ from = "<S-Left>", to = ":vertical resize +2<CR>", mode = mode_n },
	{ from = "<S-Right>", to = ":vertical resize -2<CR>", mode = mode_n },
	-- NOTE: E/R navigation needs  'bufferline' plugin
	{ from = "R", to = ":BufferLineCycleNext<CR>", mode = mode_n },
	{ from = "E", to = ":BufferLineCyclePrev<CR>", mode = mode_n },
	-- Move text up and down
	{ from = "<A-j>", to = "<Esc>:m .+1<CR>==gi", mode = mode_nv },
	{ from = "<A-k>", to = "<Esc>:m .-2<CR>==gi", mode = mode_nv },
	-- file browers
	{ from = "ff", to = "<cmd>Lf<cr>", mode = mode_n },
	-- parse on next line
	{ from = "<C-p>", to = "<cmd>pu<cr>", mode = mode_ni },
	-- better format
	{ from = "=", to = "<cmd>lua vim.lsp.buf.format()<cr>", mode = mode_n },
	-- Zoom one pane
	{ from = "<leader>-", to = "<C-W><C-\\|><C-W><C-_>", mode = mode_nvo },
	-- Restore panes
	--nnoremap <leader>= <C-w><C-=>

	-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
	-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
	-- empty mode is same as using <cmd> :map
	-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
	{ from = "j", to = 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', mode = mode_n, opt = { expr = true } },
	{ from = "k", to = 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', mode = mode_n, opt = { expr = true } },

	-- Insert --
	-- Press jj fast to enter
	{ from = "jj", to = "<ESC>", mode = mode_i },
	-- move cursor
	{ from = "<C-h>", to = "<left>", mode = mode_i },
	{ from = "<C-l>", to = "<right>", mode = mode_i },
	{ from = "<C-j>", to = "<down>", mode = mode_i },
	{ from = "<C-k>", to = "<up>", mode = mode_i },
	{ from = "<C-E>", to = "<C-right>", mode = mode_i },
	{ from = "<C-B>", to = "<C-left>", mode = mode_i },
	-- add undo break_points
	{ from = ",", to = ",<c-g>u", mode = mode_i },
	{ from = ";", to = ";<c-g>u", mode = mode_i },

	-- Visual --
	-- Stay in indent mode
	{ from = "<", to = "<gv", mode = mode_nv },
	{ from = ">", to = ">gv", mode = mode_nv },
	-- Move text up and down
	{ from = "p", to = '"_dP', mode = mode_v },
}

for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping.mode, mapping.from, mapping.to, vim.tbl_deep_extend("force", opts, mapping.opt or {}))
end

-- sudo then write ------------------------------------------------------------
vim.cmd([[
	cabbrev w!! w !sudo tee % >/dev/null
	cnoremap w!! w !sudo tee % >/dev/null
]])
