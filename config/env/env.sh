##########################################
## @Author      : caodaqian
## @CreateTime  : 2020-09-08 21:24:58
## @LastEditors : caodaqian
## @LastEditTime: 2022-05-06 12:19:02
## @Description : environment config
##########################################

## base environment config
if command -v nvim &>/dev/null; then
	export EDITOR=nvim
	export MYVIMRC=${HOME}/.config/nvim/init.lua
	export VIMDIR=${HOME}/.config/nvim
	export PATH=${PATH}:${HOME}/.local/share/nvim/lsp_servers/python
else
	export EDITOR=vim
	export MYVIMRC=${HOME}/.vim/vimrc
	export VIMDIR=${HOME}/.vim
fi
export MYTMPDIR=${HOME}/.tmp && [ ! -d "${MYTMPDIR}" ] && mkdir -p "${MYTMPDIR}"
if [[ $(uname -s) == "Darwin" ]]; then
	export LSCOLORS=Gxfxcxdxbxegedabagacad
fi
export LESSCHARSET=utf-8

## homebrew
if [[ -d "/opt/homebrew" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d "/usr/local/Homebrew" ]]; then
	eval "$(/usr/local/Homebrew/bin/brew shellenv)"
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
	## linuxbrew
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

## PATH add
export PATH=/usr/local/bin:${HOME}/.local/bin:${PATH}

## tmux config
export TMUX_TMPDIR=${MYTMPDIR}/tmux && [ ! -d "${TMUX_TMPDIR}" ] && mkdir -p "${TMUX_TMPDIR}"
export ZSH_TMUX_DEFAULT_SESSION_NAME="${USER}_dev"

## GO env
export GO111MODULE=on
export GOPATH=${HOME}/.gopath
export GOPROXY=${GOPROXY:-'https://goproxy.cn,https://proxy.golang.org,https://mirrors.aliyun.com/goproxy,direct'}
export GOSUMDB=sum.golang.google.cn
export GOBIN=$GOPATH/bin
export GOTMPDIR=${MYTMPDIR}/go && [ ! -d "${GOTMPDIR}" ] && mkdir -p "${GOTMPDIR}"
export PATH=${GOBIN}:${PATH}

## JAVA env
export JAVA_HOME=${JAVA_HOME:-"$(brew --prefix openjdk)"}
export JRE_HOME=${JRE_HOME:-"$JAVA_HOME/jre"}
export CLASSPATH=.:$JAVA_HOME/lib:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib
export PATH=${PATH}:${JAVA_HOME}/bin

## python config
export PYTHONUSERBASE=${HOME}/.local
export PATH=${PYTHONUSERBASE}/bin:${PATH}

## node config
export NODE_HOME=${NODE_HOME:-"${HOME}/.local/shard/nodejs"}
export PATH=${NODE_HOME}/bin:${PATH}

## fzf config
#export FZF_COMPLETION_TRIGGER='**'
if ! command -v tmux &>/dev/null; then
	export FZF_TMUX=1
	export FZF_TMUX_HEIGHT='80%'
fi
### fzf theme
#### one dark
#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#--color=dark
#--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
#--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
#'
#### dracula
FZF_THEME_OPTS="--color=border:#aaaaaa,label:#cccccc
--color=preview-border:#9999cc,preview-label:#ccccff
--color=list-border:#669966,list-label:#99cc99
--color=input-border:#996666,input-label:#ffcccc
--color=header-border:#6699cc,header-label:#99ccff
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
export FZF_DEFAULT_OPTS="--height 60% --highlight-line --layout reverse --multi --info=inline-right --border --padding 0 --ansi
--preview='bat --color=always --highlight-line={2} {1} 2> /dev/null || less {1}'
-m
-d:
--ansi
--reverse
--prompt='❯ '
--pointer=❯
--marker=✓
--bind=ctrl-j:jump
--bind=ctrl-k:kill-line
--bind=ctrl-n:down
--bind=ctrl-p:up
--bind=alt-j:previous-history
--bind=alt-k:next-history
--bind=ctrl-q:clear-query
--bind=alt-a:first
--bind=alt-e:last
--bind=alt-N:toggle-out
--bind=alt-P:toggle-in
--bind=ctrl-space:toggle
--bind=ctrl-o:toggle-all
--bind=ctrl-g:deselect-all
--bind=alt-g:select-all
--bind=ctrl-s:toggle-search
--bind='ctrl-\\:toggle-sort'
--bind=ctrl-^:toggle-preview-wrap
--bind=ctrl-x:toggle-preview
--bind=alt-p:preview-up
--bind=alt-n:preview-down
--bind=ctrl-v:preview-page-down
--bind=alt-v:preview-page-up
--bind=ctrl-r:preview-half-page-down
--bind=alt-r:preview-half-page-up
--bind='alt-<:preview-top'
--bind='alt->:preview-bottom'
--bind='ctrl-]:change-preview-window(bottom|right)'
--bind='alt-space:change-preview-window(+{2}+3/3,~3|+{2}+3/3,~1|)'
--bind 'ctrl-h:top,change:top'
--bind '?:change-preview-window(right|down|up|hidden|)'
--bind 'tab:toggle'
--bind 'ctrl-a:toggle-all'
${FZF_THEME_OPTS}"

## bat config
# export BAT_THEME='Catppuccin Mocha'
