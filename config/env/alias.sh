##########################################
## @Author      : caodaqian
## @CreateTime  : 2020-09-09 10:34:02
## @LastEditors : caodaqian
## @LastEditTime: 2022-05-06 11:43:37
## @Description : alias config
##########################################

# User specific aliases and functions
if [ -z "$(nvim --version 2>/dev/null)" ]; then
	alias vi='vim'
else
	alias vi='nvim'
fi
alias cls='clear'
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

## git
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gcmsg='git commit -m'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gl='git log --stat --graph --decorate --all'
alias glp='git log --stat --graph --decorate --all -p'
alias glo='git log --oneline --decorate --graph --all'
alias ggpush='git push origin "$(git_current_branch)"'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gst='git status'

## tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tl='tmux list-sessions'
alias ts='tmux new-session -s'
alias tksv='tmux kill-server'
alias tkss='tmux kill-server -t'

## bat
alias cat='bat -p'

## btop
alias top='btop'

## duf
alias df='duf'

## dust
alias du='dust'

## tldr
alias man='tldr'

## eza
alias ls='eza --icons -h --git'

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
