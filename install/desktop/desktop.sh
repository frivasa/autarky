#!/bin/bash
sudo pacman -S --noconfirm --needed keepassxc syncthing \
  nodejs npm tree-sitter-cli unzip qbittorrent ollama \
  python-json5 python-pywal fcitx5-configtool \
  hplip baobab android-file-transfer \
  gnome-disk-utility nautilus nnn \
  nwg-look inkscape gnumeric zathura zathura-pdf-mupdf evolution fuzzel

yay -S --noconfirm --needed \
  brightnessctl playerctl pamixer wiremix wireplumber \
  fcitx5 fcitx5-gtk fcitx5-qt wl-clip-persist \
  ffmpegthumbnailer python-pywalfox \
  slurp satty \
  mpv imv wf-recorder \
  zen-browser-bin chromium video-downloader

