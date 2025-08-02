#!/bin/zsh

if ! command -v nvim &>/dev/null; then
  yay -S --noconfirm --needed neovim tree-sitter-cli

  # Install own vim
  cp -rf ~/.local/share/autarky/config/nvim/* ~/.config/nvim/
fi
