" -- backup and swap files -----------------------------------------------------
set backup		" enable backup files
set writebackup " enable backup files
set swapfile	" enable swap files (useful when loading huge files)
let s:vimdir=$HOME . "/.config/nvim"
let &backupdir=s:vimdir . "/backup"  " backups location
let &directory=s:vimdir . "/tmp"	 " swap location
if exists("*mkdir")
	if !isdirectory(s:vimdir)
		call mkdir(s:vimdir, "p")
	endif
	if !isdirectory(&backupdir)
		call mkdir(&backupdir, "p")
	endif
	if !isdirectory(&directory)
		call mkdir(&directory, "p")
	endif
endif
set backupskip+=*.tmp " skip backup for *.tmp
if has("persistent_undo")
	let &undodir=&backupdir
	set undofile  " enable persistent undo
	set undolevels=100
endif
let &viminfo=&viminfo . ",n" . s:vimdir . "/.viminfo" " viminfo location
