#!/bin/zsh
ansi_art='                                                                          
   ▄████████ ███    █▄      ███        ▄████████    ▄████████    ▄█   ▄█▄ ▄██   ▄   
  ███    ███ ███    ███ ▀█████████▄   ███    ███   ███    ███   ███ ▄███▀ ███   ██▄ 
  ███    ███ ███    ███    ▀███▀▀██   ███    ███   ███    ███   ███▐██▀   ███▄▄▄███ 
  ███    ███ ███    ███     ███   ▀   ███    ███  ▄███▄▄▄▄██▀  ▄█████▀    ▀▀▀▀▀▀███ 
▀███████████ ███    ███     ███     ▀███████████ ▀▀███▀▀▀▀▀   ▀▀█████▄    ▄██   ███ 
  ███    ███ ███    ███     ███       ███    ███ ▀███████████   ███▐██▄   ███   ███ 
  ███    ███ ███    ███     ███       ███    ███   ███    ███   ███ ▀███▄ ███   ███ 
  ███    █▀  ████████▀     ▄████▀     ███    █▀    ███    ███   ███   ▀█▀  ▀█████▀  
                                                   ███    ███   ▀                   '

clear
print -e "\n$ansi_art\n"

# sudo pacman -Sy --noconfirm --needed git

print -e "\nCloning Autarky..."
rm -rf ~/.local/share/autarky/
git clone https://github.com/frivasa/autarky.git ~/.local/share/autarky >/dev/null

print -e "\nInstallation starting..."
source ~/.local/share/autarky/install.sh
