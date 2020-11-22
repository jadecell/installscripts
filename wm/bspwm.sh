#!/bin/bash

. ../wizard.sh

if [[ "$DISTRO" = "arch" ]]; then
    /bin/sh ../applications/misc.sh
    pacman --needed --noconfirm -S bspwm xcompmgr sxhkd noto-fonts fish
    yay --noconfirm -S polybar
else
    /bin/sh ../applications/misc.sh
    flaggie firefox +hwaccel
    emerge --autounmask-continue x11-misc/xcompmgr media-gfx/feh www-client/firefox x11-wm/bspwm x11-misc/sxhkd app-shells/fish
fi

echo "sxhkd &" > $HOME/.xinitrc
echo "xcompmgr &" >> $HOME/.xinitrc
echo "" >> $HOME/.xinitrc
echo "exec bspwm" >> $HOME/.xinitrc
