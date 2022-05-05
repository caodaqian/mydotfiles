" -- auto install vim-plug
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" -- plugin setting ------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

" -- key map --------------------------
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" -- file tree ------------------------
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" -- theme ----------------------------
Plug 'crusoexia/vim-monokai'
Plug 'acarapetis/vim-colors-github'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arzg/vim-colors-xcode'
Plug 'vim-airline/vim-airline'

" -- welcome page ---------------------
Plug 'mhinz/vim-startify'

" -- markdown -------------------------
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'dhruvasagar/vim-table-mode'

" -- dir plugin -----------------------
Plug 'francoiscabrol/ranger.vim'

" -- buffer close ---------------------
Plug 'rbgrouleff/bclose.vim'

" -- text crary -----------------------
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-cursorword'
Plug 'lfv89/vim-interestingwords'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'voldikss/vim-translator'
Plug 'justinmk/vim-sneak'

" -- code check -----------------------
Plug 'dense-analysis/ale'

" -- code write -----------------------
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'neoclide/jsonc.vim', { 'for': ['json', 'jsonc'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['php', 'html', 'javascript', 'css'] }
Plug 'yuezk/vim-js', { 'for': ['php', 'html', 'javascript'] }
Plug 'mattn/emmet-vim' " this plug for html

" -- code crary -----------------------
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tmhedberg/SimpylFold' " this plug for python fold
Plug 'relastle/vim-nayvy'
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less', 'go'] }
Plug 'jiangmiao/auto-pairs'

" -- vim ultest plug set -------------
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

" -- git hunks ------------------------
Plug 'lewis6991/gitsigns.nvim'

" -- window ---------------------------
Plug 'voldikss/vim-floaterm'

call plug#end()

