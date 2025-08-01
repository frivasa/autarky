#!/bin/zsh

echo "Installing zsh and Oh My Zsh..."

# Install zsh and related packages
yay -S --noconfirm --needed zsh zsh-syntax-highlighting zsh-autosuggestions

export ZSH="$HOME/.config/ohmyzsh"
# Install Oh My Zsh (unattended installation)
if [ ! -d "$HOME/.config/ohmyzsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install essential Oh My Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.config/ohmyzsh/custom}"

# Install custom Autarky theme
mkdir -p "$ZSH_CUSTOM/themes"
cp ~/.local/share/autarky/themes/autarky.zsh-theme "$ZSH_CUSTOM/themes/"

# Install pixi plugin
mkdir -p "$ZSH_CUSTOM/plugins"
mkdir -p "$ZSH_CUSTOM/plugins/pixi-env"
cp ~/.local/share/autarky/default/zsh/pixi-env.plugin.zsh "$ZSH_CUSTOM/plugins/pixi-env/"
 

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
  echo "Default shell changed to zsh. You may need to log out and back in for this to take effect."
fi