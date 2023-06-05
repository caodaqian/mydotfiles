#!/bin/sh

##########################################
# @Author      : caodaqian
# @CreateTime  : 2020-11-07 23:43:07
## @LastEditors : caodaqian
## @LastEditTime: 2022-05-06 13:16:34
# @Description : install my dotfiles
##########################################

set -eu
WORKDIR=$(dirname $(dirname $(realpath "$0")))

echo $WORKDIR
mkdir -p "${HOME}/.config"
for dir in "${WORKDIR}/config"/*; do
	dir=$(basename "$dir")
	echo "handle with $dir ..."
	if [ -d "${WORKDIR}/config/${dir}" ]; then
		ln -svF "${WORKDIR}/config/${dir}" "${HOME}/.config/${dir}"
	fi
done

# install zshrc and omz plugins
if [ -z "$(zsh --version 2>/dev/null)" ]; then
	echo "Can't find zsh, must install zsh firstly" >&2
	exit 1
elif [ ! -d "${HOME}/.oh-my-zsh" ]; then
	# check oh-my-zsh echo "Can't find .oh-my-zsh, must install omz firstly" >&2 exit 1 else
	# install omz plugins
	echo "install ohmyzsh plugins"
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open" ] && git clone https://github.com/paulirish/git-open.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open"
	[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

	# get zshrc
	echo "link zshrc to ~/.zshrc"
	ln -svf "${WORKDIR}/config/zsh/zshrc" "${HOME}/.zshrc"
	ln -svf "${WORKDIR}/config/zsh/zshenv" "${HOME}/.zshenv"
	ln -svf "${WORKDIR}/config/zsh/p10k.zsh" "${HOME}/.p10k.zsh"
fi

# install lf plugin
if [ -n "$(lf --version) 2>/dev/null" ];then
	# install colors
	if [ ! -d "${HOME}/.config/lf/colors" ];then
		echo "install lf colors"
		curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example -o ~/.config/lf/colors
	fi
	# install icons
	if [ ! -d "${HOME}/.config/lf/icons" ];then
		echo "install lf icons"
		curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example -o ~/.config/lf/icons
	fi
else
	echo "lf not found, must install lf firstly" >&2
	exit 1
fi

# install tmux config
if [ -z "$(tmux -V 2>/dev/null)" ]; then
	echo "must install tmux firstly" >&2
	exit 1
elif [ ! -d ${HOME}/.tmux ]; then
	# sync tmux.conf.local
	echo "install oh-my-tmux"
	git clone https://github.com/gpakosz/.tmux.git "${HOME}/.tmux"
	ln -svf "${HOME}/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
	ln -svf "${HOME}/.config/tmux/tmux.conf.local" "${HOME}/.tmux.conf.local"
fi

# install pacman config
if [ -z "$(pacman -v 2>/dev/null)" ]; then
	echo "not find pacman" >&2
else
	echo "link pacman.conf to /etc/pacman.conf"
	sudo ln -svf "${WORKDIR}/config/pacman/pacman.conf" "/etc/pacman.conf"
fi

# sync vim config
if [ -n "$(nvim --version 2>/dev/null)" ]; then
	echo "link vim config to ~/.vimrc"
	ln -svf "${HOME}/.config/vim/vimrc" "${VIMDIR}/vimrc"
fi

# install top config
if [ ! -f "${HOME}/.toprc" ]; then
	echo "link toprc to ~/.toprc"
	ln -svf "${HOME}/.config/top/toprc" "${HOME}/.toprc"
fi

# install xrc config
if [ ! -f "${HOME}/.Xresources" ]; then
	echo "link xrc to ~/.Xresources"
	ln -svf "${HOME}/.config/X/Xresources" "${HOME}/.Xresources"
fi
if [ ! -f "${HOME}/.xprofile" ]; then
	echo "link xprofile to ~/.xprofile"
	ln -svf "${HOME}/.config/X/xprofile" "${HOME}/.xprofile"
fi
