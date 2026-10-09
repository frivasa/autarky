#!/bin/bash

# Install bluetooth controls and service
yay -S --noconfirm --needed bluez
sudo systemctl enable --now bluetooth.service
