#!/usr/bin/env sh

# Install dotfiles if not already installed
! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/
sudo pacman --needed --noconfirm -S emacs

# Install DOOM Emacs itself
git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom install

# Move over my doom configs and sync them
cp -rf ~/dotfiles/.doom.d/ $HOME
$HOME/.emacs.d/bin/doom sync

echo ""
echo "--------DOOM EMACS--------"
echo ""
