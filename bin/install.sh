#!/usr/bin/env zsh

##########################################
# @Author      : caodaqian
# @CreateTime  : 2020-11-07 23:43:07
## @LastEditors : caodaqian
## @LastEditTime: 2022-05-06 13:16:34
# @Description : install my dotfiles
##########################################

WORKDIR=$(dirname $(dirname $(readlink -f "$0")))
SUB_MODULE="$1"
set -eu
source ${WORKDIR}/bin/common.sh
info "workdir is $WORKDIR, sub_module is $SUB_MODULE"

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
		install_fzf_git \
	)

	for install_func in ${install_list[*]};do
		if [ -n "$SUB_MODULE" -a "$install_func" != "$SUB_MODULE" ]; then
			continue
		fi
		info "exec ${install_func} *************"
		$install_func
		local ret=$?
		if [ $ret -eq 0 ]; then
			info "****************************************"
		else
			error "exec ${install_func} failed. exit_code=${ret}"
		fi
	done
}

# install dependences software
function brew_install() {
	sofrware_list=(rg gnu-sed git curl gcc cmake nodejs lf tmux dust duf btop bat tldr eza lazygit gping dog fzf neovim)
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
	fi
	
	if [ ! -d "${HOME}/.oh-my-zsh" ]; then
		# check oh-my-zsh
		warn "Can't find .oh-my-zsh, install omz firstly"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
	# install omz plugins
	info "install ohmyzsh plugins"
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open" ] && git clone https://github.com/paulirish/git-open.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/git-open"
	if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ];then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	else
		git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull
	fi
	info "install omz plugins success"
	# get zshrc
	info "link zshrc to ~/.zshrc"
	[ ! -L "${HOME}/.zshrc" ] && ln -svf "${WORKDIR}/config/zsh/zshrc" "${HOME}/.zshrc"
	[ ! -L "${HOME}/.zshenv" ] && ln -svf "${WORKDIR}/config/zsh/zshenv" "${HOME}/.zshenv"
	[ ! -L "${HOME}/.p10k.zsh" ] && ln -svf "${WORKDIR}/config/zsh/p10k.zsh" "${HOME}/.p10k.zsh"
}

# install lf plugin
function install_lf_plugin() {
	if [ -n "$(lf --version) 2>/dev/null" ];then
		# install colors
		if [ ! -f "${HOME}/.config/lf/colors" ];then
			info "install lf colors"
			curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example -o ~/.config/lf/colors
			info "install lf colors success"
		fi
		# install icons
		if [ ! -f "${HOME}/.config/lf/icons" ];then
			info "install lf icons"
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
	elif [ ! -d "$HOME/.config/.tmux" ]; then
		clone_repo ohmytmux "https://github.com/gpakosz/.tmux.git"
		ln -svf "${TMUX_INSATLL_PATH:=${HOME}/Github/ohmytmux}/.tmux.conf" "${HOME}/.config/tmux/tmux.conf"
		info "install oh-my-tmux success"
	fi
}

# install pacman config
function install_pacman_config() {
	if [ -z "$(pacman -v 2>/dev/null)" ]; then
		warn "not find pacman"
	else
		info "link pacman.conf to /etc/pacman.conf"
		sudo ln -svf "${WORKDIR}/config/pacman/pacman.conf" "/etc/pacman.conf"
		info "link pacman.conf success"
	fi
}

# install top config
function install_top_config() {
	if [ ! -f "${HOME}/.toprc" ]; then
		info "link toprc to ~/.toprc"
		ln -svf "${HOME}/.config/top/toprc" "${HOME}/.toprc"
		info "link toprc success"
	else
		warn "skip link toprc"
	fi
}

# install fzf-git
function install_fzf_git() {
	if [ -z "$(fzf --version 2>/dev/null)" ]; then
		warn "not find fzf"
	else
		clone_repo fzf_git https://github.com/junegunn/fzf-git.sh.git
	fi
}

# install xrc config
function install_x_config() {
	if [ ! -f "${HOME}/.Xresources" ]; then
		info "link xrc to ~/.Xresources"
		ln -svf "${HOME}/.config/X/Xresources" "${HOME}/.Xresources"
		info "link xrc success"
	else
		warn "skip link xrc"
	fi
	if [ ! -f "${HOME}/.xprofile" ]; then
		info "link xprofile to ~/.xprofile"
		ln -svf "${HOME}/.config/X/xprofile" "${HOME}/.xprofile"
		info "link xprofile success"
	else
		warn "skip link xprofile"
	fi
}

main
