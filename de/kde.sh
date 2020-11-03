#!/bin/sh

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

cd ~/install/scripts
if [[ "$DISTRO" = "arch" ]]; then
    sudo ./applications/misc.sh && ./applications/st.sh && ./applications/yay.sh && ./applications/nerd-fonts.sh
    sudo pacman --needed --noconfirm -S plasma kde-applications
    sudo systemctl enable sddm
else
    sudo ./applications/misc.sh && ./applications/st.sh && ./applications/nerd-fonts.sh
    sudo eselect profile set default/linux/amd64/17.1/desktop/plasma
    sudo emerge -vuDU --autounmask-continue @world
    sudo emerge --autounmask-continue kde-plasma/plasma-meta
    sudo rc-update add sddm default
fi
