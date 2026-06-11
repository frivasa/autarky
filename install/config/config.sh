#!/bin/bash

# Copy over Autarky configs
cp -R ~/.local/share/autarky/config/* ~/.config/

# bashrc, tmux.conf and starship.toml
cp ~/.local/share/autarky/default/bashrc ~/.bashrc
cp ~/.local/share/autarky/default/bash_profile ~/.bash_profile
cp ~/.local/share/autarky/default/inputrc ~/.inputrc
cp ~/.local/share/autarky/default/tmux.conf ~/.tmux.conf
cp ~/.local/share/autarky/default/starship.toml ~/.config/starship.toml
cp ~/.local/share/autarky/default/xcompose ~/.config/XCompose

# Ensure application directory exists for update-desktop-database
mkdir -p ~/.local/share/applications

# Setup GPG configuration with multiple keyservers for better reliability
sudo mkdir -p /etc/gnupg
sudo cp ~/.local/share/autarky/default/gpg/dirmngr.conf /etc/gnupg/
sudo chmod 644 /etc/gnupg/dirmngr.conf
sudo gpgconf --kill dirmngr || true
sudo gpgconf --launch dirmngr || true

# Lockout limit: 5, timeout: 4 minutes
sudo sed -i 's|^\(auth\s\+required\s\+pam_faillock.so\)\s\+preauth.*$|\1 preauth silent deny=5 unlock_time=240|' "/etc/pam.d/system-auth"
sudo sed -i 's|^\(auth\s\+\[default=die\]\s\+pam_faillock.so\)\s\+authfail.*$|\1 authfail deny=5 unlock_time=240|' "/etc/pam.d/system-auth"

# Set common git aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global pull.rebase true
git config --global init.defaultBranch master
# remember access tokens on local device
git config --global credential.helper store

# Set identification from install inputs
if [[ -n "${AUTARKY_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$AUTARKY_USER_NAME"
fi

if [[ -n "${AUTARKY_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$AUTARKY_USER_EMAIL"
fi

# set mode for apple keyboards (you never know...)
if [[ ! -f /etc/modprobe.d/hid_apple.conf ]]; then
  echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf
fi
