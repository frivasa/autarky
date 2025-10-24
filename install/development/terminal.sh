#!/bin/zsh
sudo pacman -S --noconfirm udisks2

yay -S --noconfirm --needed \
  wget curl unzip inetutils impala \
  fd eza fzf ripgrep bat jq \
  wl-clipboard fastfetch btop \
  man tldr less whois plocate

