#!/usr/bin/env sh

. ../wizard.sh
if [[ "$DISTRO" = "arch" ]]; then
    /bin/sh ../applications/misc.sh
    pacman --needed --noconfirm -S xcompmgr feh xmonad xmonad-contrib xmobar firefox fish
else
    /bin/sh ../applications/misc.sh
    flaggie firefox +hwaccel
    flaggie xmobar +timezone +xpm
    emerge --autounmask-continue x11-misc/xcompmgr media-gfx/feh x11-wm/xmonad x11-wm/xmonad-contrib x11-misc/xmobar www-client/firefox app-shells/fish
fi

echo "exec dbus-launch xmonad" > $HOME/.xinitrc

echo
echo "--------XMONAD INSTALLED SUCCESSFULLY--------"
echo

exit 0
