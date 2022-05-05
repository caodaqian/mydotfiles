##########################################
## @Author      : caodaqian
## @CreateTime  : 2020-09-09 10:34:02
## @LastEditors : caodaqian
## @LastEditTime: 2020-12-22 12:05:01
## @Description : alias config
##########################################

# User specific aliases and functions
if [[ -z "$(nvim --version)" ]]; then
	alias vi='vim'
else
	alias vi='nvim'
fi
alias cls='clear'
alias ls='ls $COLOR_OPTION'
alias la='ls -ah $COLOR_OPTION'
alias ll='ls -lh $COLOR_OPTION'
alias l='ls -lA $COLOR_OPTION'
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
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbD='git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
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
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ggpull='git pull origin "$(git_current_branch)"'
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


## backup
function backup() {
	if [[ ! $# -eq 1 ]]; then
		echo "usage: backup filename"
	else
		mv "$1" "$1.bak"
	fi
}
alias bcp='backup'
function unbackup() {
	if [[ ! $# -eq 1 ]]; then
		echo "usage: backup filename"
	else
		mv "$1" "${1%*.bak}"
	fi
}
alias ubcp='unbackup'

## fzf function
### ----------------------- fzf function ------------------------
# CTRL-T - Paste the selected file path(s) into the command line
__fsel() {
  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

function find-in-file() {
	grep --line-buffered --color=never -r "" * | fzf
}
### ----------------------- fzf function ------------------------

## python
function pypath() {
	python -c "import sys; print(str(sys.path).replace(',', '\n'))"
}

