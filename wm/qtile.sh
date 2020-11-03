#!/usr/bin/env bash

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

# Execute base scripts and install programs

cd ~/installscripts/

if [[ "$DISTRO" = "arch" ]]; then
    ./applications/misc.sh && ./applications/st.sh && ./applications/yay.sh && ./applications/nerd-fonts.sh
    sudo pacman --noconfirm -S xcompmgr feh ranger firefox qtile python-pip python-psutil python-iwlib
else
    ./applications/misc.sh && ./applications/st.sh && ./applications/nerd-fonts.sh
    sudo flaggie firefox +hwaccel
    sudo flaggie xmobar +wifi +iwlib
    sudo emerge --autounmask-continue x11-misc/xcompmgr media-gfx/feh app-misc/ranger x11-wm/qtile dev-python/pip www-client/firefox app-shells/zsh
    pip3 install --user psutil iwlib
fi


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
