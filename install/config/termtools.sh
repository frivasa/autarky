#!/bin/bash

echo "Installing/Configuring keyd, Starship, and Tmux"

# Install term utilities and related packages
sudo pacman -S --noconfirm --needed starship tmux keyd foot pacman-contrib
# handle xcompose and input handling
sudo pacman -S --noconfirm --needed fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt

# enable plugins for tmux
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# copy config and enable keyd bindings
sudo mkdir -p /etc/keyd
sudo cp ~/.local/share/autarky/default/default.conf /etc/keyd/default.conf
if ! systemctl is-enabled keyd.service | grep -q enabled; then
  sudo systemctl enable keyd
fi

# copy pacman config (avoid extracting /docs and other locales)
sudo cp ~/.local/share/autarky/default/pacman.conf /etc/pacman.conf

