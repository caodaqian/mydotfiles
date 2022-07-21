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
if [[ $(uname -s) == "Linux" ]]; then
	COLOR_OPTION='--color=auto'
elif [[ $(uname -s) == "Darwin" ]]; then
	export LSCOLORS=Gxfxcxdxbxegedabagacad
fi
export LESSCHARSET=utf-8

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
export JAVA_HOME=${JAVA_HOME:-'/usr/local/opt/openjdk'}
export JRE_HOME=${JRE_HOME:-'/usr/local/opt/openjdk/jre'}
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
export PATH=${JAVA_HOME}/bin:${PATH}

## fzf config
export FZF_COMPLETION_TRIGGER='~~'
if [[ -z "$(tmux --version 2>/dev/null)" ]]; then
	export FZF_TMUX=1
	export FZF_TMUX_HEIGHT='80%'
fi
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_DEFAULT_OPTS='--bind "ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)" --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --style=numbers --color=always --line-range :500 {}" --preview-window down:3:hidden:wrap --bind "?:toggle-preview" --height 50% --layout=reverse --border'
### fzf theme
#### one dark
#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#--color=dark
#--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
#--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
#'
#### dracula
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

## python config
export PATH=${HOME}/.local/bin:${PATH}

## node config
export NODE_HOME=${NODE_HOME:-"${HOME}/.local/shard/nodejs"}
export PATH=${NODE_HOME}/bin:${PATH}

## ranger config
export RANGER_LOAD_DEFAULT_RC=false
