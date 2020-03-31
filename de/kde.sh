#!/bin/bash

bash ../misc.sh

sudo pacman --needed --noconfirm -S plasma kde-applications

cd $HOME

echo "exec startplasma-x11" > .xinitrc

startx
