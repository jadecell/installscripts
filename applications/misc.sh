#!/bin/bash

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

# Installs the base xorg display system

if [[ "$DISTRO" = "arch" ]]; then
    sudo pacman --noconfirm --needed -S xorg xorg-xinit dmenu termite
else
    VIDEODRIVER=$(lspci -k | grep 'nouveau\|qxl\|i915\|i965' | awk '{print $5}')
    echo " " >> /etc/portage/make.conf
    echo "VIDEO_CARDS=\"$VIDEODRIVER\"" >> /etc/portage/make.conf
    echo "INPUT_DEVICES=\"libinput synaptics\"" >> /etc/portage/make.conf
    emerge --autounmask-continue x11-base/xorg-x11 x11-terms/rxvt-unicode
fi

# Finished

echo " "
echo "---------------------INSTALLED MISC PROGRAMS----------------------"
echo " "
