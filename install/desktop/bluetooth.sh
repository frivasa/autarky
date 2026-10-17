#!/bin/bash

# Install bluetooth controls and service
yay -S --noconfirm --needed bluez bluez-tools bluez-utils
sudo systemctl enable --now bluetooth.service
