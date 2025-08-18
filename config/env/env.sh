##########################################
## @Author      : caodaqian
## @CreateTime  : 2020-09-08 21:24:58
## @LastEditors : caodaqian
## @LastEditTime: 2022-05-06 12:19:02
## @Description : environment config
##########################################

## base environment config
if [[ -z "$(nvim --version 2>/dev/null)" ]]; then
	export EDITOR=vim
	export MYVIMRC=${HOME}/.vim/vimrc
	export VIMDIR=${HOME}/.vim
else
	export EDITOR=nvim
	export MYVIMRC=${HOME}/.config/nvim/init.lua
	export VIMDIR=${HOME}/.config/nvim
	export PATH=${PATH}:${HOME}/.local/share/nvim/lsp_servers/python
fi
export MYTMPDIR=${HOME}/.tmp && [ ! -d "${MYTMPDIR}" ] && mkdir -p "${MYTMPDIR}"
if [[ $(uname -s) == "Darwin" ]]; then
	export LSCOLORS=Gxfxcxdxbxegedabagacad
fi
export LESSCHARSET=utf-8

## homebrew
test -d /usr/local/Homebrew && eval "$(/usr/local/Homebrew/bin/brew shellenv)"
test -d /opt/homebrew && eval "$(/opt/homebrew/bin/brew shellenv)"
## linuxbrew
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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
if [[ -z "$(tmux --version 2>/dev/null)" ]]; then
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
export FZF_DEFAULT_OPTS="--highlight-line --height ~40% --layout reverse --multi --info=inline-right --border --padding 0 --ansi
--bind 'ctrl-h:top,change:top'
--bind '?:change-preview-window(hidden|)'
--preview 'fzf-preview.sh {}'
--input-label ' Input '
--header-label ' File Type '
--bind 'focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}'
--bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"'
${FZF_THEME_OPTS}"

## bat config
# export BAT_THEME='Catppuccin Mocha'
