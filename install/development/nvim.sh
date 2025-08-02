#!/bin/zsh

if ! command -v nvim &>/dev/null; then
  yay -S --noconfirm --needed neovim luarocks tree-sitter-cli

  # Install own vim
  rm -rf ~/.config/nvim
  cp -R ~/.local/share/autarky/config/nvim/* ~/.config/nvim/
  # echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua
fi
