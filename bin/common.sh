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
	echo "\033[${bg};${fg}m${level^^}:${message}\033[0m"
}

function info() {
	echo $(format "info" "$1")
}

function warn() {
	echo $(format "warn" "$1")
}

function error() {
	echo $(format "error" "$1")
}
