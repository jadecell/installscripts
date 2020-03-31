#!/bin/bash

bash ../misc.sh

sudo pacman --needed --noconfirm -S gnome gnome-extra

cd $HOME

echo "export XDG_SESSION_TYPE=x11" > .xinitrc
echo "export GDK_BACKEND=x11" >> .xinitrc
echo "exec gnome-session" >> .xinitrc

startx
