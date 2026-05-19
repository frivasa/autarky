#!/bin/bash

yay -S --noconfirm --needed ttf-font-awesome ttf-ia-writer noto-fonts noto-fonts-emoji

if [ -z "$AUTARKY_BARE" ]; then
  # relic here to remember the older font: jetbrains-mono-nerd
  # yay -S --noconfirm --needed ttf-jetbrains-mono-nerd noto-fonts-cjk noto-fonts-extra
  yay -S --noconfirm --needed ttf-iosevka-nerd noto-fonts-cjk noto-fonts-extra
fi
