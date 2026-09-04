#!/bin/bash

# gnome-themes-extra adds Adwaita-dark theme, kvantum-qt5 is dark?
yay -S --noconfirm --needed kvantum-qt5 gnome-themes-extra
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface icon-theme "HighContrast"
gsettings set org.gnome.desktop.privacy remember-recent-files false

# Set initial theme
mkdir -p ~/.config/autarky/current
ln -snf ~/.local/share/autarky/themes/master_camera ~/.config/autarky/current/theme
ln -snf ~/.local/share/autarky/themes/master_camera/backgrounds/02-fill-camera.png ~/.config/autarky/current/background

# Set specific app links for current theme
mkdir -p ~/.config/mpv
mkdir -p ~/.config/mpv/script-opts/
# include= does not wokr within script-opts
ln -snf ~/.config/autarky/current/theme/mpv.osc.conf ~/.config/mpv/script-opts/osc.conf

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/autarky/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/autarky/current/theme/mako.ini ~/.config/mako/config
