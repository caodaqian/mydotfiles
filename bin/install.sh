#!/usr/bin/env zsh

WORKDIR=$(dirname $(dirname $(readlink -f "$0")))
SUB_MODULE="$1"
set -eu
source ${WORKDIR}/bin/common.sh
info "workdir is $WORKDIR, sub_module is $SUB_MODULE"

function main() {
	install_list=( \
		brew_install \
		link_config \
		zsh_plugin \
		yazi_plugin \
		tmux_plugin \
		top_config \
		x_config \
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
	sofrware_list=(rg gnu-sed git curl gcc cmake nodejs tmux dust duf tldr eza lazygit gping fzf neovim pipx bottom uv cowsay fastfetch bat)
	brew install ${sofrware_list[*]}

	### install fzf-git
	if [ -z "$(fzf --version 2>/dev/null)" ]; then
		warn "not find fzf"
	else
		clone_repo fzf_git https://github.com/junegunn/fzf-git.sh.git
	fi
}

function link_config() {
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

# install oh-my-zsh and omz plugins
function zsh_plugin() {
	if [ -z "$(zsh --version 2>/dev/null)" ]; then
		error "Can't find zsh, must install zsh firstly"
		exit 1
	fi
	
	if [ -z "$(omz version 2>/dev/null)" ]; then
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
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/autoupdate" ] && git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/autoupdate"
	[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/fzf-tab" ] && git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab"
	info "install omz plugins success"
	# link zshrc
	[ ! -L "${HOME}/.zshrc" ] && ln -svf "${WORKDIR}/config/zsh/zshrc" "${HOME}/.zshrc"
	[ ! -L "${HOME}/.zshenv" ] && ln -svf "${WORKDIR}/config/zsh/zshenv" "${HOME}/.zshenv"
	[ ! -L "${HOME}/.zlogin" ] && ln -svf "${WORKDIR}/config/zsh/zlogin" "${HOME}/.zlogin"
	[ ! -L "${HOME}/.p10k.zsh" ] && ln -svf "${WORKDIR}/config/zsh/p10k.zsh" "${HOME}/.p10k.zsh"
	info "link zshrc to ~/.zshrc"
}

# install tmux config
function tmux_plugin() {
	if [ -z "$(tmux -V 2>/dev/null)" ]; then
		warn "must install tmux firstly"
		exit 1
	elif [ ! -d "$HOME/.config/.tmux" ]; then
		clone_repo ohmytmux "https://github.com/gpakosz/.tmux.git"
		ln -svf "${TMUX_INSATLL_PATH:=${HOME}/Github/ohmytmux}/.tmux.conf" "${HOME}/.config/tmux/tmux.conf"
		info "install oh-my-tmux success"
	fi

	## tmux plugin dependencies
	brew install yq ## tmux status line window rename
}

# install top config
function top_config() {
	if [ ! -f "${HOME}/.toprc" ]; then
		info "link toprc to ~/.toprc"
		ln -svf "${HOME}/.config/top/toprc" "${HOME}/.toprc"
		info "link toprc success"
	else
		warn "skip link toprc"
	fi
}

# install xrc config
function x_config() {
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

# install yazi config
function yazi_plugin() {
	brew install yazi
	## install smart enter
	ya pkg list | grep 'smart-enter' 2>&1 >/dev/null || ya pkg add yazi-rs/plugins:smart-enter
	## install git plugin
	ya pkg list | grep 'git' 2>&1 >/dev/null || ya pkg add yazi-rs/plugins:git
	## install compress plugin
	ya pkg list | grep 'compress' 2>&1 >/dev/null || ya pkg add KKV9/compress
	## install yabm plugin
	ya pkg list | grep 'yamb' 2>&1 >/dev/null || ya pkg add h-hg/yamb
	## install diff plugin
	ya pkg list | grep 'diff' 2>&1 >/dev/null || ya pkg add yazi-rs/plugins:diff
	## install chmod plugin
	ya pkg list | grep 'chmod' 2>&1 >/dev/null || ya pkg add yazi-rs/plugins:chmod
	## install toggle-pane plugin
	ya pkg list | grep 'toggle-pane' 2>&1 >/dev/null || ya pkg add yazi-rs/plugins:toggle-pane
	## install githead plugin
	ya pkg list | grep 'githead' 2>&1 >/dev/null || ya pkg add llanosrocas/githead
	## install eza-preview plugin
	ya pkg list | grep 'eza-preview' 2>&1 >/dev/null || ya pkg add ahkohd/eza-preview
	## install theme
	ya pkg list | grep 'catppuccin-mocha' 2>&1 >/dev/null || ya pkg add yazi-rs/flavors:catppuccin-mocha
	ya pkg list | grep 'catppuccin-latte' 2>&1 >/dev/null || ya pkg add yazi-rs/flavors:catppuccin-latte
	ya pkg list | grep 'catppuccin-frappe' 2>&1 >/dev/null || ya pkg add yazi-rs/flavors:catppuccin-frappe
	ya pkg list | grep 'catppuccin-macchiato' 2>&1 >/dev/null || ya pkg add yazi-rs/flavors:catppuccin-macchiato
	ya pkg list | grep 'gruvbox-dark' 2>&1 >/dev/null || ya pkg add bennyyip/gruvbox-dark
	ya pkg list | grep 'everforest-medium' 2>&1 >/dev/null || ya pkg add Chromium-3-Oxide/everforest-medium
}

main
