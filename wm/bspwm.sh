#!/bin/bash

# Runs all scripts needed before install

bash yay.sh
bash misc.sh

# Installs needed software

sudo pacman --needed --noconfirm -S bspwm xcompmgr sxhkd noto-fonts
yay --noconfirm -S polybar

# Clones the dot files

git clone https://gitlab.com/jadecell/dotfiles.git $HOME/homefiles
chown `whoami` $HOME/homefiles/
chown `whoami` $HOME/homefiles/*
cp -rf $HOME/homefiles/.* $HOME
rm -rf $HOME/homefiles/

# Copy the bspwm xinit to the xinitrc

cd $HOME
rm -f .xinitrc
cp -f .bspwmxinitrc .xinitrc
