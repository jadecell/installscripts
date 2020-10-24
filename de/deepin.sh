#!/usr/bin/env sh

cd $HOME/installscripts/
./applications/misc.sh && ./applications/yay.sh
sudo pacman --needed --noconfirm -S deepin deepin-extra

echo "exec startdde" > $HOME/.xinitrc

echo
echo "Type startx to launcho"
echo
