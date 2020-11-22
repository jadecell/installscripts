#!/bin/sh

. ../wizard.sh
if [[ "$DISTRO" = "arch" ]]; then
    /bin/sh ../applications/misc.sh
    pacman --needed --noconfirm -S plasma kde-applications
    systemctl enable sddm
else
    /bin/sh ../applications/misc.sh
    eselect profile set default/linux/amd64/17.1/desktop/plasma
    emerge -vuDU --autounmask-continue @world
    emerge --autounmask-continue kde-plasma/plasma-meta
    rc-update add sddm default
fi
