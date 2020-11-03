#!/usr/bin/env sh

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

# Install dotfiles if not already installed
! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/

if [[ "$DISTRO" = "arch" ]]; then
   sudo pacman --noconfirm --needed -S emacs

else
    sudo flaggie emacs +gui
    sudo emerge --autounmask-continue app-editors/emacs
fi

# Install DOOM Emacs itself
git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom install

# Move over my doom configs and sync them
cp -rf ~/dotfiles/.doom.d/ $HOME
$HOME/.emacs.d/bin/doom sync

echo ""
echo "--------DOOM EMACS--------"
echo ""
