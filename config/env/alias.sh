# User specific aliases and functions
if command -v nvim &>/dev/null; then
	alias vi='nvim'
else
	alias vi='vim'
fi
alias cls='clear'
if [[ $(uname -s) == "Linux" ]]; then
	export COLOR_OPTION='--color=auto'
	alias grep='grep $COLOR_OPTION'
	alias egrep='egrep $COLOR_OPTION'
fi
alias diff='diff -aNur'

## bat
alias cat='bat --paging=never'
alias less='bat'

## bottom
alias top='btm'

## duf
unalias duf 2>/dev/null
alias df='duf'

## dust
alias du='dust'

## tldr
alias man='tldr'

## eza
## other alias by omz-eza plugin
alias l='ls'

## fzf
alias -g F='| fzf'
alias copypath='fzf --multi --bind="ctrl-a:select-all"| tr -d "\n" | tee >(pbcopy)'

## gping
alias ping='gping'

## dog
alias dig='dog'

## backup
function backup() {
	if [ ! $# -eq 1 ]; then
		echo "usage: backup filename"
	else
		mv "$1" "$1.bak"
	fi
}
alias bcp='backup'
function unbackup() {
	if [ ! $# -eq 1 ]; then
		echo "usage: backup filename"
	else
		mv "$1" "${1%*.bak}"
	fi
}
alias ubcp='unbackup'

## python
function pypath() {
	python -c "import sys; print(str(sys.path).replace(',', '\n'))"
}
