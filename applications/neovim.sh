#!/usr/bin/env sh

. ../wizard.sh
if [[ "$DISTRO" = "arch" ]]; then
    pacman --needed --noconfirm -S neovim python-pynvim nodejs npm yarn
else
    emerge --autounmask-continue app-editors/neovim dev-python/pip net-libs/nodejs sys-apps/yarn
    pip3 install pynvim
fi
