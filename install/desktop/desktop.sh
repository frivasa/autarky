#!/bin/zsh
# dumping everything else here, don't judge me!
sudo pacman -S --noconfirm keepassxc syncthing \
  nodejs npm tree-sitter-cli unzip qbittorrent ollama \
  python-json5 python-pywal python-pywalfox cmus fcitx5-configtool \
  hplip baobab android-file-transfer gthumb nemo nemo-fileroller \
  nwg-look


yay -S --noconfirm --needed \
  brightnessctl playerctl pamixer wiremix wireplumber \
  fcitx5 fcitx5-gtk fcitx5-qt wl-clip-persist \
  sushi ffmpegthumbnailer \
  slurp satty \
  mpv evince imv \
  zen-browser-bin chromium video-downloader

# load nemo defaults
dconf load /org/nemo/ < ~/.local/share/autarky/default/nemo.dconf

# Add screen recorder based on GPU
if lspci | grep -qi 'nvidia'; then
  yay -S --noconfirm --needed wf-recorder
else
  yay -S --noconfirm --needed wl-screenrec
fi
