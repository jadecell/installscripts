#!/usr/bin/env bash

. ../wizard.sh
if [[ "$DISTRO" = "arch" ]]; then
    /bin/sh ../applications/misc.sh
    pacman --noconfirm --needed -S xcompmgr feh ranger firefox
else
    /bin/sh ../applications/misc.sh
    flaggie firefox +hwaccel
    emerge --autounmask-continue x11-misc/xcompmgr media-gfx/feh app-misc/ranger www-client/firefox
fi

# Clone needed repos

mkdir -p ~/.local/{bin,src}
cd ~/.local/src/

git clone https://gitlab.com/jadecell/dwm.git
git clone https://gitlab.com/jadecell/slstatus.git

# Make dwm

cd ~/.local/src/dwm/
make install

# Make slstatus

cd ~/.local/src/slstatus/
make install

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
