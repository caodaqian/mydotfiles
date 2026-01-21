-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local options = {
	-- basic config
	autochdir = true,
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- use system clipboard
	cmdheight = 1, -- keep status bar position close to bottom
	compatible = false, -- no compatible
	encoding = "utf-8",
	expandtab = false, -- disable convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	history = 88, -- history number
	scrolloff = 8, -- keep 8 height offset from above and bottom
	shiftwidth = 8, -- the number of spaces inserted for each indentation
	showmatch = true, -- show match pattern
	smarttab = true,
	softtabstop = 8,
	synmaxcol = 240, -- scroll lines that are too long just slow when a line is too long
	tabstop = 8, -- insert 2 spaces for a tab
	ttyfast = true,
	wildignorecase = true,
	wildmenu = true, -- enable tab completion menu
	-- display config
	hidden = true, -- Required to keep multiple buffers open multiple buffers
	ruler = true, -- Show the cursor position all the time
	cursorcolumn = false, -- cursor column.
	cursorline = true, -- highlight current line
	diffopt = "vertical,filler,internal,context:4", -- vertical diff split view
	number = true, -- set numbered lines
	relativenumber = false, -- set relative numbered lines
	showcmd = true, -- show partial command line (default)
	showmode = true, -- we don't need to see things like -- INSERT -- anymore if false
	showtabline = 2, -- always show tabs
	title = true, -- change the terminal title
	wrap = true, -- display lines as one long line
	wrapscan = true, -- wrap around when searching
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Native inline completions don't support being shown as regular completions
vim.g.ai_cmp = false
