#!/usr/bin/env sh

sudo ./full_system-gentoo.sh

git clone https://gitlab.com/jadecell/dotfiles.git ~/dotfiles
cp -rf ~/dotfiles/.* ~
rm -rf ~/.git
rm -rf ~/dotfiles

pip install --user pynvim
sudo ./applications/nerd-fonts.sh
