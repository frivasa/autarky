#!/bin/bash

yay -S --noconfirm --needed \
  gnome-keyring vesktop-bin obs-studio pinta

# Copy over Autarky application references (.desktop files)
source ~/.local/share/autarky/bin/autarky-refresh-applications || true

# neovim reigns sup-meme
xdg-mime default nvim.desktop text/plain

# Open all images with qimgv
xdg-mime default qimgv.desktop image/png
xdg-mime default qimgv.desktop image/jpeg
xdg-mime default qimgv.desktop image/gif
xdg-mime default qimgv.desktop image/webp
xdg-mime default qimgv.desktop image/bmp
xdg-mime default qimgv.desktop image/tiff
xdg-mime default qimgv.desktop image/svg+xml
xdg-mime default qimgv.desktop image/avif

# Open PDFs with okular
xdg-mime default okularApplication_pdf.desktop application/pdf

# Browser
xdg-settings set default-web-browser zen.desktop
xdg-mime default zen.desktop x-scheme-handler/http
xdg-mime default zen.desktop x-scheme-handler/https

# Open video files with mpv
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-msvideo
xdg-mime default mpv.desktop video/avi
xdg-mime default mpv.desktop video/x-matroska
xdg-mime default mpv.desktop video/x-flv
xdg-mime default mpv.desktop video/x-ms-wmv
xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/ogg
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/quicktime
xdg-mime default mpv.desktop video/3gpp
xdg-mime default mpv.desktop video/3gpp2
xdg-mime default mpv.desktop video/x-ms-asf
xdg-mime default mpv.desktop video/x-ogm+ogg
xdg-mime default mpv.desktop video/x-theora+ogg
xdg-mime default mpv.desktop application/ogg

# tell system what's up
update-desktop-database ~/.local/share/applications
