#!/bin/zsh

# Use dark mode for QT apps too (like kdenlive)
if ! yay -Q kvantum-qt5 &>/dev/null; then
  yay -S --noconfirm kvantum-qt5
fi

# Prefer dark mode everything
if ! yay -Q gnome-themes-extra &>/dev/null; then
  yay -S --noconfirm gnome-themes-extra # Adds Adwaita-dark theme
fi

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Setup theme links
mkdir -p ~/.config/autarky/themes
for f in ~/.local/share/autarky/themes/*; do ln -nfs "$f" ~/.config/autarky/themes/; done

# Set initial theme
mkdir -p ~/.config/autarky/current
ln -snf ~/.config/autarky/themes/tokyo-night ~/.config/autarky/current/theme
ln -snf ~/.config/autarky/current/theme/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png ~/.config/autarky/current/background

# Set specific app links for current theme
ln -snf ~/.config/autarky/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/autarky/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/autarky/current/theme/mako.ini ~/.config/mako/config
