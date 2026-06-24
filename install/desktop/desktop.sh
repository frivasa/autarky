#!/bin/bash
sudo pacman -S --noconfirm --needed keepassxc syncthing \
  nodejs npm tree-sitter-cli unzip qbittorrent ollama \
  python-json5 python-pywal \
  hplip baobab android-file-transfer \
  gnome-disk-utility nautilus nnn \
  nwg-look inkscape gnumeric zathura zathura-pdf-mupdf evolution fuzzel

yay -S --noconfirm --needed \
  brightnessctl playerctl pamixer wiremix wireplumber \
  wl-clip-persist \
  ffmpegthumbnailer python-pywalfox \
  slurp satty \
  mpv imv wf-recorder \
  zen-browser-bin chromium video-downloader

# enable mpv-nnn playlist interaction (; p)
sudo cp /usr/share/mpv/scripts/umpv ~/.local/bin/umpv
sudo chmod +x ~/.local/bin/umpv
cp --parents ~/.local/share/autarky/config/nnn/plugins/addtoplaylist ~/.config/nnn/plugins/addtoplaylist
sudo chmod +x ~/.config/nnn/plugins/addtoplaylist
# this enables sending selected files to mpv playlist from nnn

# use a nnn wrapper for easier configuration across launch methods (shell or fuzzel)
sudo cp ~/.local/share/autarky/bin/nnn ~/.local/bin/nnn
sudo chmod +x ~/.local/bin/nnn
