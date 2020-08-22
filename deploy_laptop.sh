#!/usr/bin/env bash

# Execute base scripts and install programs

cd ~/installscripts/
sudo ./misc.sh && ./yay.sh && ./nerd-fonts.sh
sudo pacman --noconfirm -S xcompmgr feh ranger emacs tlp alacritty xmonad xmonad-contrib xmobar ttf-ubuntu-font-family thunderbird jre-openjdk jdk-openjdk intellij-idea-community-edition trayer
yay --noconfirm -S waterfox-current-bin

# Moving some files from dotfiles

mkdir -p ~/.config/{alacritty,xmobar}

cd ~
git clone https://gitlab.com/jadecell/dotfiles
cd dotfiles
cp .Xresources ~
cp .config/xmobarlaptop/xmobarrclaptop ~/.config/xmobar/xmobarrc0
cp .config/alacritty/alacritty.yml ~/.config/alacritty/
cp -r .xmonad ~
cd ~
git clone https://gitlab.com/jadecell/wallpapers.git
cd wallpapers
cp ~/wallpapers/Abstract/gruvbox-buildings.png ~/.config/wallpaper

# Doom emacs

git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Installs Doom emacs config
 
cp -rf ~/dotfiles/.doom.d/ ~

~/.emacs.d/bin/doom sync

# Starting services
 
sudo systemctl enable --now tlp

# Making the .xinitrc

cd ~
echo "exec xmonad" > ~/.xinitrc

# Recompile Xmonad

xmonad --recompile

# Oh-my-zsh
 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
