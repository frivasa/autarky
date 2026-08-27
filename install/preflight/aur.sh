#!/bin/bash

# Manually install yay from AUR if not already available
if ! command -v yay &>/dev/null; then
    sudo pacman -S --needed base-devel git
    cd /tmp
    rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    rm -rf /tmp/yay-bin
fi

# Add fun and color to the pacman installer
if ! grep -q "ILoveCandy" /etc/pacman.conf; then
  sudo sed -i '/^\[options\]/a Color\nILoveCandy' /etc/pacman.conf
fi
