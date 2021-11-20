#!/bin/sh
##########################################
## @Author      : caodaqian
## @CreateTime  : 2020-11-07 23:43:07
## @LastEditors : caodaqian
## @LastEditTime: 2020-12-03 15:53:11
## @Description : sync ranger config
##########################################

set -e
WORKDIR=$(dirname $(dirname $(readlink -f "$0")))

## sync config
if [ ! -d ${HOME}/.config ]; then
	echo "load my config"
	cp -r "${WORKDIR}/config" "${HOME}/.config"
fi
. "$HOME/.config/*.sh"

## install ranger plugin
git clone https://github.com/alexanderjeurissen/ranger_devicons "${HOME}/.config/ranger/plugins/ranger_devicons"

## sync vim config
if [[ -n "$(nvim --version 2>/dev/null)" ]]; then
	ln -s "${HOME}/.config/vim/vimrc" "${VIMDIR}/vimrc"
fi
