#!/bin/zsh
# dumping everything else here, don't judge me!
sudo pacman -S --noconfirm keepassxc audacious tmux syncthing \
  nodejs npm tree-sitter-cli unzip qbittorrent ollama keepassxc \
  python-json5 python-pywal python-pywalfox cmus fcitx5-configtool \
  hplip okular baobab android-file-transfer


yay -S --noconfirm --needed \
  brightnessctl playerctl pamixer wiremix wireplumber \
  fcitx5 fcitx5-gtk fcitx5-qt wl-clip-persist \
  nautilus sushi ffmpegthumbnailer \
  slurp satty \
  mpv evince imv \
  zen-browser-bin chromium video-downloader

# Add screen recorder based on GPU
if lspci | grep -qi 'nvidia'; then
  yay -S --noconfirm --needed wf-recorder
else
  yay -S --noconfirm --needed wl-screenrec
fi
