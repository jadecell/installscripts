#!/usr/bin/env bash

# Execute base scripts and install programs

cd ~/installscripts/
sudo ./misc.sh && ./yay.sh && ./nerd-fonts.sh
sudo pacman --noconfirm -S xcompmgr feh ranger emacs tlp alacritty xmonad xmonad-contrib xmobar ttf-ubuntu-font-family thunderbird
yay -S brave-bin 

# Moving some files from dotfiles

mkdir -p ~/.config/{alacritty,xmobar}

cd ~
git clone https://gitlab.com/jadecell/dotfiles
cd dotfiles
cp .Xresources ~
cp .config/xmobar/configs/xmobarrclaptop ~/.config/xmobar/xmobarrc0
cp .config/alacritty/alacritty.yml ~/.config/alacritty/
cp -r .xmonad ~

# Doom emacs

git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install


# Starting services
 
sudo systemctl enable --now tlp

# Making the .xinitrc

cd ~
echo "exec xmonad" > ~/.xinitrc

# Oh-my-zsh
 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
