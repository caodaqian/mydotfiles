#!/bin/sh
##########################################
## @Author      : caodaqian
## @CreateTime  : 2020-11-07 23:43:07
## @LastEditors : caodaqian
## @LastEditTime: 2022-02-13 00:19:54
## @Description : sync ranger config
##########################################

set -eu
WORKDIR=$(dirname $(dirname $(realpath "$0")))

## sync config
echo "load my config"
cp -r "${WORKDIR}/config" "${HOME}/.config"
for file in "$HOME/.config/env/*.sh"
do
	. $file
done

## install zsh
if [ -z "$(zsh --version 2>/dev/null)" ]; then
	echo "Can't find zsh, must install zsh firstly" >&2
	exit 1
fi

## install oh-my-zsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
	echo "Can't find .oh-my-zsh, then will install oh-my-zsh, maybe you should try again after installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

if [ -d ${HOME}/.oh-my-zsh ]; then
	echo "install zsh plugins autosuggestions syntax-highlighting git-open powerlevel10k"
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open" ] && git clone https://github.com/paulirish/git-open.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open"
	[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# get zshrc
echo "cp my zshrc to ~/.zshrc"
cp "${WORKDIR}/zsh/zshrc" "${HOME}/.zshrc"
source "${HOME}/.zshrc"

## install ranger plugin
if [ -n "$(ranger --version 2>/dev/null)" ]; then
	git clone https://github.com/alexanderjeurissen/ranger_devicons "${HOME}/.config/ranger/plugins/ranger_devicons"
else
	echo "ranger not found, please install it firstly" >&2
	exit 1
fi

## install tmux
if [ -z "$(tmux -V 2>/dev/null)" ]; then
	echo "must install tmux firstly" >&2
	exit 1
fi

## sync tmux.conf.local
if [[ ! -d ${HOME}/.tmux ]]; then
	echo "install oh-my-tmux"
	git clone https://github.com/gpakosz/.tmux.git "${HOME}/.tmux"
	ln -s -f "${HOME}/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
	ln -s -f "${HOME}/.config/tmux/tmux.conf.local" "${HOME}/.tmux.conf.local"
fi

## sync vim config
if [ -n "$(nvim --version 2>/dev/null)" ]; then
	ln -s -f "${HOME}/.config/vim/vimrc" "${VIMDIR}/vimrc"
fi

## sync top config
if [ ! -f "${HOME}/.toprc"]; then
	ln -s -f "${HOME}/.config/top/toprc" "${HOME}/.toprc"
fi

## mkdir MYPATH
[ ! -d "${MYTMPDIR}" ] && mkdir -p "${MYTMPDIR}"
[ ! -d "${GOTMPDIR}" ] && mkdir -p "${GOTMPDIR}"
[ ! -d "${TMUX_TMPDIR}" ] && mkdir -p "${TMUX_TMPDIR}"
