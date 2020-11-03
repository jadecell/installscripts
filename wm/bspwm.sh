#!/bin/bash

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

# Runs all scripts needed before install
cd ~/installscripts

if [[ "$DISTRO" = "arch" ]]; then
    sudo ./applications/misc.sh && ./applications/st.sh && ./applications/yay.sh && ./applications/nerd-fonts.sh
    sudo pacman --needed --noconfirm -S bspwm xcompmgr sxhkd noto-fonts
    yay --noconfirm -S polybar
else
    sudo ./applications/misc.sh && ./applications/st.sh && ./applications/nerd-fonts.sh
    sudo flaggie firefox +hwaccel
    sudo emerge --autounmask-continue x11-misc/xcompmgr media-gfx/feh app-misc/ranger www-client/firefox x11-wm/bspwm x11-misc/sxhkd
fi

# Clones the dot files
cd ~

! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/
cp -r dotfiles/.* ~

# Create the xinitrc

cd $HOME
echo "sxhkd &" > $HOME/.xinitrc
echo "xcompmgr &" >> $HOME/.xinitrc
echo "" >> $HOME/.xinitrc
echo "exec bspwm" >> $HOME/.xinitrc
