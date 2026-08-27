#!/bin/bash

# dev and some tuis
sudo pacman -S --noconfirm --needed \
  rust          clang   llvm \
  imagemagick   lazygit lazydocker \
  trash-cli     nethogs dust \
  diff-so-fancy udisks2 usb_modeswitch \
  exiftool      tree    reflector \
  bash-completion

yay -S --noconfirm --needed \
  curl      unzip        inetutils \
  impala    fd           eza \
  fzf       ripgrep      jq \
  fastfetch wl-clipboard man \
  less      btop         whois

# Pixi (uv but better)
if ! command -v pixi &>/dev/null; then
  export PIXI_NO_PATH_UPDATE=1
  sudo pacman -S --noconfirm --needed pixi
fi
