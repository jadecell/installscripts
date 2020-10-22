#!/usr/bin/env bash

# Execute base scripts and install programs

cd ~/installscripts/
sudo ./misc.sh && ./st.sh && ./yay.sh && ./nerd-fonts.sh
sudo pacman --noconfirm -S xcompmgr feh ranger firefox qtile python-pip python-psutil python-iwlib


# Moving some files from dotfiles

cd ~
mkdir -p ~/.config/qtile
git clone https://gitlab.com/jadecell/dotfiles
cd dotfiles
cp .Xresources ~
cp -r ~/dotfiles/.config/qtile/* ~/.config/qtile/

pip install psutil iwlib

# Making the .xinitrc

cd ~
echo "xrdb $HOME/.Xresources &" >> ~/.xinitrc
echo "xcompmgr &" >> ~/.xinitrc
echo "" >> ~/.xinitrc
echo "exec qtile" >> ~/.xinitrc

echo ""
echo "------------FINISHED RICING DWM------------"
echo ""
