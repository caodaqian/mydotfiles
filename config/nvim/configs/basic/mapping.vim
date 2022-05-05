" -- basic mapping --------------------------------------------------------------
let mapleader=" "
let maplocalleader=" "
map S :w<CR>
map Q :q<CR>
map <C-Q> :q!<CR>
map <leader>R :source $MYVIMRC<CR>
inoremap jj <esc>
map sl :set nosplitright<CR>:vsplit<CR>
map sr :set splitright<CR>:vsplit<CR>
map su :set nosplitbelow<CR>:split<CR>
map sd :set splitbelow<CR>:split<CR>
nnoremap < <<
nnoremap > >>
nnoremap H <home>
nnoremap L <end>
inoremap <C-H> <left>
inoremap <C-L> <right>
inoremap <C-J> <up>
inoremap <C-K> <down>
inoremap <C-E> <C-right>
inoremap <C-B> <C-left>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
noremap <silent> <leader>y "+y
noremap <silent> <leader>Y "+Y
noremap <silent> <leader>p "+p
noremap <silent> <leader>P "+P
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
nnoremap <C-T> :tabedit<CR>
nnoremap <silent> tr :tabNext<CR>
nnoremap <silent> tl :tabs<CR>
" make arrow keys, home/end/pgup/pgdown, and function keys work when inside tmux
if exists('$TMUX') && (system("tmux show-options -wg xterm-keys | cut -d' ' -f2") =~ '^on')
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
	execute "set <xHome>=\e[1;*H"
	execute "set <xEnd>=\e[1;*F"
	execute "set <Insert>=\e[2;*~"
	execute "set <Delete>=\e[3;*~"
	execute "set <PageUp>=\e[5;*~"
	execute "set <PageDown>=\e[6;*~"
	execute "set <xF1>=\e[1;*P"
	execute "set <xF2>=\e[1;*Q"
	execute "set <xF3>=\e[1;*R"
	execute "set <xF4>=\e[1;*S"
	execute "set <F5>=\e[15;*~"
	execute "set <F6>=\e[17;*~"
	execute "set <F7>=\e[18;*~"
	execute "set <F8>=\e[19;*~"
	execute "set <F9>=\e[20;*~"
	execute "set <F10>=\e[21;*~"
	execute "set <F11>=\e[23;*~"
	execute "set <F12>=\e[24;*~"
endif
