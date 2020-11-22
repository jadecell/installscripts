#!/bin/sh

. ../wizard.sh
if [[ "$DISTRO" = "arch" ]]; then
    /bin/sh ../applications/misc.sh
    pacman --needed --noconfirm -S gnome gnome-extra
    echo "export XDG_SESSION_TYPE=x11" > $HOME/.xinitrc
    echo "export GDK_BACKEND=x11" >> $HOME/.xinitrc
    echo "exec gnome-session" >> $HOME/.xinitrc
    startx
else
    /bin/sh ../applications/misc.sh
    eselect profile set default/linux/amd64/17.1/desktop/gnome
    emerge -vuDU --autounmask-continue @world
    emerge --autounmask-continue gnome-base/gnome
    env-update && source /etc/profile && echo "exec gnome-session" > $HOME/.xinitrc && startx
fi
