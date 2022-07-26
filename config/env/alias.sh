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
alias ls='ls $COLOR_OPTION'
alias la='ls -ah $COLOR_OPTION'
alias ll='ls -lh $COLOR_OPTION'
alias l='ls -la $COLOR_OPTION'
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
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged' alias gbr='git branch --remote'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gcmsg='git commit -m'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
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
alias gfo='git fetch origin'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'
alias gst='git status'

## tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tl='tmux list-sessions'
alias ts='tmux new-session -s'
alias tksv='tmux kill-server'
alias tkss='tmux kill-server -t'

## ranger
alias ra='ranger'

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

## exa
alias ls='exa'

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
