#!/usr/bin/env sh

# Install dotfiles if not already installed
! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/

sudo pacman --needed --noconfirm -S neovim python-pynvim nodejs npm yarn

cp -r $HOME/dotfiles/.config/nvim/ $HOME/.config/

echo
echo "--------INSTALLED NEOVIM--------"
echo

exit 0
