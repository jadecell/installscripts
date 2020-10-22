#!/usr/bin/env bash

# Execute base scripts and install programs

cd ~/installscripts/
sudo ./applications/misc.sh && ./applications/st.sh && ./applications/yay.sh && ./applications/nerd-fonts.sh
sudo pacman --noconfirm -S xcompmgr feh ranger firefox

# Clone needed repos

mkdir -p ~/.local/{bin,src}
cd ~/.local/src/

git clone https://gitlab.com/jadecell/dwm.git
git clone https://gitlab.com/jadecell/slstatus.git

# Make dwm

cd ~/.local/src/dwm/
sudo make install

# Make slstatus

cd ~/.local/src/slstatus/
sudo make install

# Moving some files from dotfiles

cd ~
git clone https://gitlab.com/jadecell/dotfiles
cd dotfiles
cp .Xresources ~

# Making the .xinitrc

cd ~
echo "slstatus &" >> ~/.xinitrc
echo "xrdb ~/.Xresources &" >> ~/.xinitrc
echo "xcompmgr &" >> ~/.xinitrc
echo "" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc

echo ""
echo "------------FINISHED RICING DWM------------"
echo ""
