#!/bin/zsh

if ! command -v pixi &>/dev/null; then
  export PIXI_NO_PATH_UPDATE=1
  sudo pacman -S ---noconfirm pixi
fi
