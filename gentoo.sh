#!/usr/bin/env bash
set -euo pipefail

[ "$(whoami)" = "root" ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1

USERNAME="$(whoami)"

sudo sed -i -e "s|#\ Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\"|Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/home/$USERNAME/.local/bin\"|g" /etc/sudoers

~/.local/repos/dotfiles/setup home

mkdir ~/scrot

rm ~/.bash_profile
ln -s ~/.local/repos/dotfiles/home/.config/shell/profile ~/.zprofile
ln -s ~/.local/repos/dotfiles/home/.config/shell/profile ~/.bash_profile
ln -s ~/.local/repos/dotfiles/home/.config/x11/xprofile ~/.xprofile

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.local/share/zsh/zsh-syntax-highlighting/
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.local/share/zsh/zsh-vi-mode/

cd ~/.local/repos/dwmblocks || exit 1
make && sudo make install

cd ~/.local/repos/dwm || exit 1
make && sudo make install

cd ~/.local/repos/st || exit 1
make && sudo make install

cd ~/.local/repos/dmenu || exit 1
make && sudo make install

clear
echo "Everything deployed correctly!"
