#!/bin/bash

echo "Installing/Configuring keyd, Starship, and Tmux"

# Install term utilities and related packages
sudo pacman -S --noconfirm --needed starship tmux keyd foot

# enable plugins for tmux
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# copy config and enable keyd bindings
sudo mkdir -p /etc/keyd
sudo cp ~/.local/share/autarky/default/default.conf /etc/keyd/default.conf
if ! systemctl is-enabled keyd.service | grep -q enabled; then
  sudo systemctl enable keyd
fi

