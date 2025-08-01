#!/bin/zsh

echo "Installing zsh and Oh My Zsh..."

# Install zsh and related packages
yay -S --noconfirm --needed zsh zsh-completions

# Install Oh My Zsh (unattended installation)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install essential Oh My Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Install custom Omarchy theme
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/themes"
cp ~/.local/share/omarchy/themes/omarchy.zsh-theme "$ZSH_CUSTOM/themes/"

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
  echo "Default shell changed to zsh. You may need to log out and back in for this to take effect."
fi