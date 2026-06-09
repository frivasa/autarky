#!/bin/bash
sudo pacman -S --noconfirm --needed udisks2 usb_modeswitch tree reflector

sudo pacman -S --noconfirm --needed \
  trash-cli nethogs dust \
  diff-so-fancy \
  exiftool

yay -S --noconfirm --needed \
  wget      curl   unzip \
  inetutils impala fd \
  eza       fzf    ripgrep \
  jq      wl-clipboard fastfetch btop \
  man tldr less whois plocate

