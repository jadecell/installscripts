#!/bin/bash

# Set homepath

HOMEPATH="$1"

# Installs needed software

sudo pacman --needed --noconfirm -S bspwm xcompmgr sxhkd noto-fonts
sudo -u "$2" yay --noconfirm -S polybar

# Clones the dot files

git clone https://gitlab.com/jadecell/dotfiles.git $HOMEPATH

# Copy the bspwm xinit to the xinitrc

cd "$1"

cp -f .bspwmxinitrc .xinitrc
