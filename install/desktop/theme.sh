#!/bin/bash

# gnome-themes-extra adds Adwaita-dark theme, kvantum-qt5 is dark?
yay -S --noconfirm --needed kvantum-qt5 gnome-themes-extra yamis-icon-theme-git
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface icon-theme "HighContrast"
gsettings set org.gnome.desktop.privacy remember-recent-files false

# Set initial theme
mkdir -p ~/.config/autarky/current
mkdir -p ~/.conifg/noctalia/palettes
ln -snf ~/.local/share/autarky/themes/diogenes ~/.config/autarky/current/theme
ln -snf ~/.local/share/autarky/themes/diogenes/backgrounds/01-center-diogenes_JeanLeonGerome.jpg ~/.config/autarky/current/background
ln -snf ~/.local/share/autarky/themes/diogenes/noctalia.json ~/.config/noctalia/palettes/Diogenes.json

# Set specific app links for current theme
mkdir -p ~/.config/mpv
mkdir -p ~/.config/mpv/script-opts/
# include= does not wokr within script-opts
ln -snf ~/.config/autarky/current/theme/mpv.osc.conf ~/.config/mpv/script-opts/osc.conf

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/autarky/current/theme/btop.theme ~/.config/btop/themes/current.theme

# link a keyboard icon for fcitx5
ln -s /usr/share/icons/yet-another-monochrome-icon-set/preferences/scalable/preferences-desktop-keyboard.svg ~/.local/share/icons/yet-another-monochrome-icon-set/devices/scalable/input-keyboard-symbolic.svg

