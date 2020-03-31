#!/bin/bash

# Runs all scripts needed before install

bash yay.sh
bash misc.sh

# Installs needed software

sudo pacman --needed --noconfirm -S bspwm xcompmgr sxhkd noto-fonts
sudo -u "$1" yay --noconfirm -S polybar

# Clones the dot files

git clone https://gitlab.com/jadecell/dotfiles.git $HOME/homefiles
chown "$1" $HOME/homefiles
mv $HOME/homefiles $HOME

# Copy the bspwm xinit to the xinitrc

cd "$HOME"
rm -f .xinitrc
cp -f .bspwmxinitrc .xinitrc
