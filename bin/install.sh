#!/usr/bin/env zsh

##########################################
# @Author      : caodaqian
# @CreateTime  : 2020-11-07 23:43:07
## @LastEditors : caodaqian
## @LastEditTime: 2022-05-06 13:16:34
# @Description : install my dotfiles
##########################################

set -eu
WORKDIR=$(dirname $(dirname $(readlink -f "$0")))
echo "workdir is $WORKDIR"
source ${WORKDIR}/bin/common.sh

function main() {
	install_list=( \
		brew_install \
		link_config_dir \
		install_zsh_config \
		install_lf_plugin \
		install_tmux_config \
		install_pacman_config \
		install_top_config \
		install_x_config \
	)

	for install_func in ${install_list[*]};do
		echo $(format "NOTE" "exec ${install_func} *************")
		$install_func
		echo $(format "NOTE" "****************************************")
	done
}

# install dependences software
function brew_install() {
	sofrware_list=(rg gnu-sed git curl gcc cmake node lf curl tmux dust duf btop tldr exa)
	brew install ${sofrware_list[*]}
}

function link_config_dir() {
	mkdir -p "${HOME}/.config"
	for dir in "${WORKDIR}/config"/*; do
		dir=$(basename "$dir")
		if [ -d "${WORKDIR}/config/${dir}" -a ! -L "${HOME}/.config/${dir}" ]; then
			ln -svF "${WORKDIR}/config/${dir}" "${HOME}/.config/${dir}"
			if [ $? -eq 0 ];then
				info "link config ${dir} success"
			else
				error "link config ${dir} fail"
			fi
		else
			warn "skip link config ${dir}"
		fi
	done
}

# install zshrc and omz plugins
function install_zsh_config() {
	if [ -z "$(zsh --version 2>/dev/null)" ]; then
		error "Can't find zsh, must install zsh firstly"
		exit 1
	elif [ ! -d "${HOME}/.oh-my-zsh" ]; then
		# check oh-my-zsh
		error "Can't find .oh-my-zsh, must install omz firstly"
		exit 1
	else
		# install omz plugins
		echo "install ohmyzsh plugins"
		[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
		[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open" ] && git clone https://github.com/paulirish/git-open.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open"
		[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

	# get zshrc
	echo "link zshrc to ~/.zshrc"
	[ ! -L "${HOME}/.zshrc" ] && ln -svf "${WORKDIR}/config/zsh/zshrc" "${HOME}/.zshrc"
	[ ! -L "${HOME}/.zshenv" ] && ln -svf "${WORKDIR}/config/zsh/zshenv" "${HOME}/.zshenv"
	[ ! -L "${HOME}/.p10k.zsh" ] && ln -svf "${WORKDIR}/config/zsh/p10k.zsh" "${HOME}/.p10k.zsh"
	info "install omz plugins success"
	fi
}

# install lf plugin
function install_lf_plugin() {
	if [ -n "$(lf --version) 2>/dev/null" ];then
		# install colors
		if [ ! -f "${HOME}/.config/lf/colors" ];then
			echo "install lf colors"
			curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example -o ~/.config/lf/colors
			info "install lf colors success"
		fi
		# install icons
		if [ ! -f "${HOME}/.config/lf/icons" ];then
			echo "install lf icons"
			curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example -o ~/.config/lf/icons
			info "install lf icons success"
		fi
	else
		warn "lf not found, must install lf firstly"
	fi
}

# install tmux config
function install_tmux_config() {
	if [ -z "$(tmux -V 2>/dev/null)" ]; then
		warn "must install tmux firstly"
		exit 1
	elif [ ! -d ${HOME}/.tmux ]; then
		# sync tmux.conf.local
		echo "install oh-my-tmux"
		git clone https://github.com/gpakosz/.tmux.git "${HOME}/.tmux"
		ln -svf "${HOME}/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
		ln -svf "${HOME}/.config/tmux/tmux.conf.local" "${HOME}/.tmux.conf.local"
		info "install oh-my-tmux success"
	fi
}

# install pacman config
function install_pacman_config() {
	if [ -z "$(pacman -v 2>/dev/null)" ]; then
		warn "not find pacman"
	else
		echo "link pacman.conf to /etc/pacman.conf"
		sudo ln -svf "${WORKDIR}/config/pacman/pacman.conf" "/etc/pacman.conf"
		info "link pacman.conf success"
	fi
}

# install top config
function install_top_config() {
	if [ ! -f "${HOME}/.toprc" ]; then
		echo "link toprc to ~/.toprc"
		ln -svf "${HOME}/.config/top/toprc" "${HOME}/.toprc"
		info "link toprc success"
	else
		warn "skip link toprc"
	fi
}

# install xrc config
function install_x_config() {
	if [ ! -f "${HOME}/.Xresources" ]; then
		echo "link xrc to ~/.Xresources"
		ln -svf "${HOME}/.config/X/Xresources" "${HOME}/.Xresources"
		info "link xrc success"
	else
		warn "skip link xrc"
	fi
	if [ ! -f "${HOME}/.xprofile" ]; then
		echo "link xprofile to ~/.xprofile"
		ln -svf "${HOME}/.config/X/xprofile" "${HOME}/.xprofile"
		info "link xprofile success"
	else
		warn "skip link xprofile"
	fi
}

main
