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
		bat_config \
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
	sofrware_list=(rg gnu-sed git curl gcc cmake nodejs tmux dust duf tldr eza lazygit gping dog fzf neovim pipx bottom uv)
	brew install ${sofrware_list[*]}

	### install neovim plugin
	pipx install pynvim neovim

	### install fzf-git
	if [ -z "$(fzf --version 2>/dev/null)" ]; then
		warn "not find fzf"
	else
		clone_repo fzf_git https://github.com/junegunn/fzf-git.sh.git
	fi
}

# install bat config
function bat_config() {
	brew install bat

	## install catppuccin theme
	mkdir -p "$(bat --config-dir)/themes"
	wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
	wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
	wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
	wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

	bat cache --build
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
	brew install reattach-to-user-namespace ## @tmux-yank
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
	brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font
	## install smart enter
	ya pack -l | grep 'smart-enter' 2>&1 >/dev/null || ya pack -a yazi-rs/plugins:smart-enter
	## install git plugin
	ya pack -l | grep 'git' 2>&1 >/dev/null || ya pack -a yazi-rs/plugins:git
	## install compress plugin
	ya pack -l | grep 'compress' 2>&1 >/dev/null || ya pack -a KKV9/compress
	## install yabm plugin
	ya pack -l | grep 'yamb' 2>&1 >/dev/null || ya pack -a h-hg/yamb
	## install diff plugin
	ya pack -l | grep 'diff' 2>&1 >/dev/null || ya pack -a yazi-rs/plugins:diff
	## install chmod plugin
	ya pack -l | grep 'chmod' 2>&1 >/dev/null || ya pack -a yazi-rs/plugins:chmod
	## install max-preview plugin
	ya pack -l | grep 'max-preview' 2>&1 >/dev/null || ya pack -a yazi-rs/plugins:max-preview
	## install githead plugin
	ya pack -l | grep 'githead' 2>&1 >/dev/null || ya pack -a llanosrocas/githead
	## install eza-preview plugin
	ya pack -l | grep 'eza-preview' 2>&1 >/dev/null || ya pack -a ahkohd/eza-preview
	## install theme
	ya pack -l | grep 'catppuccin-mocha' 2>&1 >/dev/null || ya pack -a yazi-rs/flavors:catppuccin-mocha
	ya pack -l | grep 'catppuccin-latte' 2>&1 >/dev/null || ya pack -a yazi-rs/flavors:catppuccin-latte
	ya pack -l | grep 'catppuccin-frappe' 2>&1 >/dev/null || ya pack -a yazi-rs/flavors:catppuccin-frappe
	ya pack -l | grep 'catppuccin-macchiato' 2>&1 >/dev/null || ya pack -a yazi-rs/flavors:catppuccin-macchiato
	ya pack -l | grep 'gruvbox-dark' 2>&1 >/dev/null || ya pack -a bennyyip/gruvbox-dark
	ya pack -l | grep 'everforest-medium' 2>&1 >/dev/null || ya pack -a Chromium-3-Oxide/everforest-medium
}

main
