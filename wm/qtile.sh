#!/usr/bin/env bash

. ../wizard.sh

if [[ "$DISTRO" = "arch" ]]; then
    /bin/sh ../applications/misc.sh
    pacman --noconfirm -S xcompmgr feh ranger firefox qtile python-pip python-psutil python-iwlib
else
    /bin/sh ../applications/misc.sh
    flaggie firefox +hwaccel
    flaggie xmobar +wifi +iwlib
    emerge --autounmask-continue x11-misc/xcompmgr media-gfx/feh app-misc/ranger x11-wm/qtile dev-python/pip www-client/firefox app-shells/zsh
    pip3 install psutil iwlib
fi

# Making the .xinitrc
echo "xrdb $HOME/.Xresources &" >> $HOME/.xinitrc
echo "xcompmgr &" >> $HOME/.xinitrc
echo "" >> $HOME/.xinitrc
echo "exec qtile" >> $HOME/.xinitrc

echo ""
echo "------------FINISHED RICING QTILE------------"
echo ""
