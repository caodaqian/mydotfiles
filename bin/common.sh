#!/bin/bash

## for printting
function format() {
	level=$1
	message=$2
	case $level in
	"info")
		fg=32
		bg=0
		;;
	"warn")
		fg=33
		bg=0
		;;
	"error")
		fg=37
		bg=41
		;;
	*)
		fg=34
		bg=0
		;;
	esac
	echo "\033[${bg};${fg}m${level}:${message}\033[0m"
}

function info() {
	echo -e $(format "info" "$1")
}

function warn() {
	echo -e $(format "warn" "$1")
}

function error() {
	echo -e $(format "error" "$1")
}

function clone_repo() {
	local name=$1
	local git_repo_url=$2
	if [ -z "$name" ] || [ -z "${git_repo_url}" ]; then
		return 255
	fi

	[ ! -d "${DOTFILE_CLONE_PATH:="${HOME}/Github"}" ] && mkdir -p "${DOTFILE_CLONE_PATH}"
	local clone_dir="${DOTFILE_CLONE_PATH}/${name}"
	if [ ! -d "${clone_dir}" ]; then
		info "install $name to $clone_dir"
		git clone "$git_repo_url" "$clone_dir"
	fi
	return 0
}
