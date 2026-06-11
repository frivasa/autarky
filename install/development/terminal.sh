#!/bin/bash
sudo pacman -S --noconfirm --needed \
  trash-cli     nethogs dust \
  diff-so-fancy udisks2 usb_modeswitch \
  exiftool      tree    reflector

yay -S --noconfirm --needed \
  wget      curl         unzip \
  inetutils impala       fd \
  eza       fzf          ripgrep \
  jq        wl-clipboard fastfetch \
  man       tldr         less \
  btop      whois        plocate
