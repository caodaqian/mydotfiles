#!/usr/bin/env zsh

source "${HOME}/.zshrc"

brew update
brew upgrade

upgrade_oh_my_zsh_all

npm upgrade -g
npx skills update -g

ya pkg upgrade --discard

alias nvim-mason-update='nvim --headless -c "luafile ~/.config/nvim/lua/scripts/mason-update.lua"'
