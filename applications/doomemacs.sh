#!/usr/bin/env sh

. ../wizard.sh
if [[ "$DISTRO" = "arch" ]]; then
   echo $SUDOPASSWORD | sudo -S pacman --noconfirm --needed -S emacs

else
    echo $SUDOPASSWORD | sudo -S flaggie emacs +gui
    echo $SUDOPASSWORD | sudo -S emerge --autounmask-continue app-editors/emacs
fi

# Install DOOM Emacs itself
git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom install
