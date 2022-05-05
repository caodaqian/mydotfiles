" -- basic setting -------------------------------------------------------------
set nocompatible
set encoding=utf-8
syntax on
filetype plugin indent on
set foldmethod=indent
set foldlevel=99
set autoindent
set noexpandtab
set tabstop=4 " it work at expandtab
set softtabstop=0 " should same like tabstop or close it
set shiftwidth=4 " should smae like tabstop
set smarttab
set history=88
set clipboard=unnamed
set autochdir


" -- colorscheme -------------------------------------------------------------
let $t_ut=''
set t_Co=256
set background=dark
colorscheme desert

" -- searching -----------------------------------------------------------------
set wrapscan	" wrap around when searching
set incsearch	" show match results while typing search pattern
if (&t_Co > 2 || has("gui_running"))
	set hlsearch  " highlight search terms
endif
set showmatch
set ignorecase
set smartcase

" -- command mode --------------------------------------------------------------
set wildmenu					" enable tab completion menu
set wildmode=longest:full,full	" complete till longest common string, then full
set wildignore+=.git			" ignore the .git directory
set wildignore+=*.DS_Store		" ignore Mac finder/spotlight crap
if exists ("&wildignorecase")
	set wildignorecase
endif

" -- scroll lines that are too long just slow when a line is too long ----------
set synmaxcol=1000
set ttyfast

" -- expand filenames with forward slash ----------------------------------------
if exists("+shellslash")
	set shellslash
endif

" -- sudo then write ------------------------------------------------------------
cabbrev w!! w !sudo tee % >/dev/null
cnoremap w!! w !sudo tee % >/dev/null
