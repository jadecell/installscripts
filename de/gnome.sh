#!/bin/sh

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

cd ~/installscripts

if [[ "$DISTRO" = "arch" ]]; then
    sudo ./applications/misc.sh && ./applications/st.sh && ./applications/yay.sh && ./applications/nerd-fonts.sh
    sudo pacman --needed --noconfirm -S gnome gnome-extra
    echo "export XDG_SESSION_TYPE=x11" > .xinitrc
    echo "export GDK_BACKEND=x11" >> .xinitrc
    echo "exec gnome-session" >> $HOME/.xinitrc
    startx
else
    sudo ./applications/misc.sh && ./applications/st.sh && ./applications/nerd-fonts.sh
    sudo eselect profile set default/linux/amd64/17.1/desktop/gnome
    sudo emerge -vuDU --autounmask-continue @world
    sudo emerge --autounmask-continue gnome-base/gnome
    sudo env-update && sudo source /etc/profile && echo "exec gnome-session" > $HOME/.xinitrc && startx
fi
