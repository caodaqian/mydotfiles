# User specific aliases and functions
if [ -z "$(nvim --version 2>/dev/null)" ]; then
	alias vi='vim'
else
	alias vi='nvim'
fi
alias cls='clear'
if [[ $(uname -s) == "Linux" ]]; then
	export COLOR_OPTION='--color=auto'
fi
alias grep='grep $COLOR_OPTION'
alias egrep='egrep $COLOR_OPTION'
alias diff='diff -aNur'

## hadoop
alias hcat='hadoop fs -text'
alias hls='hadoop fs -ls'
alias hdu='hadoop fs -du -h'
alias hrm='hadoop fs -rm -r'
alias hhead='hadoop fs -head'
alias htail='hadoop fs -tail'
alias hmkdir='hadoop fs -mkdir'
alias hlist='yarn application -list'
alias hkill='yarn application -kill'
alias hrunning='mapred job -set-max-task-running'

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
alias l='eza'
alias eza='eza --icons'

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
