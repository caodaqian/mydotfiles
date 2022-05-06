local options = {
    -- basic config
    compatible = false, -- no compatible
    encoding = 'utf-8',
    fileencoding = "utf-8", -- the encoding written to a file
    filetype = 'on', -- enable filetype
    foldmethod = "expr", -- fold with nvim_treesitter
    foldexpr = "nvim_treesitter#foldexpr()",
    foldenable = false, -- no fold to be applied when open a file
    foldlevel = 99, -- if not set this, fold will be everywhere
    expandtab = false, -- disable convert tabs to spaces
    tabstop = 4, -- insert 2 spaces for a tab
    softtabstop = 0,
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    smarttab = true,
    history = 88, -- history number
    clipboard = "unnamedplus", -- use system clipboard
    autochdir = true,
    incsearch = true, -- show match results while typing search pattern
    showmatch = true, -- show match pattern
    ignorecase = true, -- ignore case in search patterns
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    wildmenu = true, -- enable tab completion menu
    wildignorecase = true,
    synmaxcol = 1000, -- scroll lines that are too long just slow when a line is too long
    ttyfast = true,
    scrolloff = 8, -- keep 8 height offset from above and bottom
    sidescrolloff = 8, -- keep 8 width offset from left and right
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    numberwidth = 4, -- set number column width to 2 {default 4}
    backup = false, -- creates a backup file
    cmdheight = 1, -- keep status bar position close to bottom
    completeopt = {"menuone", "noselect"}, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    hlsearch = true, -- highlight all matches on previous search pattern
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    -- display config
    showmode = true, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    laststatus = 2,
    title = true, -- change the terminal title
    lazyredraw = true, -- do not redraw when executing macros
    cursorline = true, -- highlight current line
    cursorcolumn = false, -- cursor column.
    termguicolors = true, -- set term gui colors (most terminals support this)
    number = false, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    showcmd = true, -- show partial command line (default)
    wrap = true, -- display lines as one long line
    wrapscan = true, -- wrap around when searching
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    spell = false, -- add spell support
    spelllang = {'en_us'}, -- support which languages?
    diffopt = "vertical,filler,internal,context:4" -- vertical diff split view
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "syntax on"
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- WSL yank support
vim.cmd [[
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
		augroup WSLYank
				autocmd!
				autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
		augroup END
endif
]]

