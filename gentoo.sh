#!/usr/bin/env bash
set -euo pipefail

[ "$(whoami)" = "root" ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1

USERNAME="$(whoami)"

sudo sed -i -e "s|#\ Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\"|Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/home/$USERNAME/.local/bin\"|g" /etc/sudoers

mkdir -p ~/.config
mkdir -p ~/.local/{repos,lib,share}

git clone https://gitlab.com/jadecell/dotfiles ~/.local/repos/dotfiles
~/.local/repos/dotfiles/setup home

mkdir ~/scrot

[ ! -d "$HOME/.local/repos/wallpapers" ] && git clone https://gitlab.com/jadecell/wallpapers.git ~/.local/repos/wallpapers && ln -s ~/.local/repos/wallpapers/29.png ~/.config/wallpaper

ln -s ~/.local/repos/dotfiles/home/.config/shell/profile ~/.zprofile
ln -s ~/.local/repos/dotfiles/home/.config/shell/profile ~/.bash_profile
ln -s ~/.local/repos/dotfiles/home/.config/x11/xprofile ~/.xprofile

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.local/share/zsh-syntax-highlighting/
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.local/share/zsh-vi-mode/

git clone https://gitlab.com/jadecell/dwmblocks.git ~/.local/repos/dwmblocks
cd ~/.local/repos/dwmblocks || exit 1
make && sudo make install

git clone https://gitlab.com/jadecell/dwm.git ~/.local/repos/dwm
cd ~/.local/repos/dwm || exit 1
make && sudo make install

git clone https://gitlab.com/jadecell/st.git ~/.local/repos/st
cd ~/.local/repos/st || exit 1
make && sudo make install

git clone https://gitlab.com/jadecell/dmenu.git ~/.local/repos/dmenu
cd ~/.local/repos/dmenu || exit 1
make && sudo make install

git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d/ || exit 1
~/.emacs.d/bin/doom -y install

clear
echo "Everything deployed correctly!"

