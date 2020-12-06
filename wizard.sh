#!/usr/bin/env bash

# Stopping root from running
[ $EUID -eq 0 ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1

USERNAME=$(whoami)

# Determine the distro
[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"
SCRIPTSDIRECTORY=$(pwd)
read -p "Enter your sudo password: " SUDOPASSWORD

clear

cat << EOF
wizard.sh -- A wizard to install various elements of my rice

---------------
Window Managers
---------------
Option 1: BSPWM
Option 2: DWM
Option 3: XMonad
Option 4: Qtile

--------------------
Desktop Environments
--------------------
Option 5: Gnome
Option 6: KDE

------------
Applications
------------
Option 7: Doom Emacs
Option 8: Xorg
Option 9: Neovim
Option 10: Nerd Fonts
Option 11: St
Option 12: Yay

EOF
read -p "Choice: " SCRIPTOTRUN

touch $SCRIPTSDIRECTORY/values
echo "SCRIPTSDIRECTORY=$SCRIPTSDIRECTORY" > $SCRIPTSDIRECTORY/values
echo "SUDOPASSWORD=$SUDOPASSWORD" >> $SCRIPTSDIRECTORY/values
echo "DISTRO=$DISTRO" >> $SCRIPTSDIRECTORY/values
echo "USERNAME=$USERNAME" >> $SCRIPTSDIRECTORY/values

case $SCRIPTOTRUN in
    1) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/wm/bspwm.sh ;;
    2) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/wm/dwm.sh ;;
    3) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/wm/xmonad.sh ;;
    4) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/wm/qtile.sh ;;
    5) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/de/gnome.sh ;;
    6) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/de/kde.sh ;;
    7) /bin/sh $SCRIPTSDIRECTORY/applications/doomemacs.sh ;;
    8) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/applications/misc.sh ;;
    9) echo $SUDOPASSWORD | sudo -S $SCRIPTSDIRECTORY/applications/neovim.sh ;;
    10) /bin/sh $SCRIPTSDIRECTORY/applications/nerd-fonts.sh ;;
    11) /bin/bash $SCRIPTSDIRECTORY/applications/st.sh ;;
    12) /bin/sh $SCRIPTSDIRECTORY/applications/yay.sh ;;
esac

# Install nerd fonts
/bin/sh $SCRIPTSDIRECTORY/applications/nerd-fonts.sh

# Install dotfiles
! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/
cp -r $HOME/dotfiles/.* $HOME
rm -rf $HOME/.git

[ $SCRIPTOTRUN -eq 3 ] && xmonad --recompile
