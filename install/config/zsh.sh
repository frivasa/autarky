#!/bin/zsh

echo "Installing Zsh and Starship..."

# Install zsh and related packages
sudo pacman -S --noconfirm starship tmux
yay -S --noconfirm --needed zsh zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode kitty

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
  echo "Default shell changed to zsh. You may need to log out and back in for this to take effect."
fi
