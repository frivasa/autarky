#!/bin/bash

yay -S --noconfirm --needed \
  gnome-keyring vesktop-bin \
  obs-studio pinta

# Copy over Autarky applications
source ~/.local/share/autarky/bin/autarky-refresh-applications || true
