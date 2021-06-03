#!/usr/bin/env sh

[ "$(whoami)" = "root" ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1

USERNAMEOFUSER="$(whoami)"
sudo chown -R "$USERNAMEOFUSER":"$USERNAMEOFUSER" ~

git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg --noconfirm -si
cd ..
rm -rf paru-bin
sudo sed -i -e "s/#BottomUp/BottomUp/g ; s/#SudoLoop/SudoLoop/g ; s/#UpgradeMenu/UpgradeMenu/g" /etc/paru.conf

sudo mkdir -p /etc/pacman.d/hooks
CPUTHREADS=$(grep -c processor /proc/cpuinfo)
CPUTHREADSPLUSONE=$((CPUTHREADS + 1))
sudo sed -i -e 's/#Color/Color/g ; s/#VerbosePkgLists/VerbosePkgLists/g' /etc/pacman.conf
sudo sed -i -e 's/#HookDir\ \ \ \ \ =\ \/etc\/pacman.d\/hooks\//HookDir\ \ \ \ \ =\ \/etc\/pacman.d\/hooks\//g' /etc/pacman.conf
sudo sed -i '37i ILoveCandy' /etc/pacman.conf
sudo sed -i -e "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$CPUTHREADSPLUSONE\"/g" /etc/makepkg.conf
sudo sed -i -e "s|#\ Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\"|Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/home/$USERNAMEOFUSER/.local/bin\"|g" /etc/sudoers

~/.local/repos/dotfiles/packages-pacman
~/.local/repos/dotfiles/setup home

sudo chsh -s /bin/zsh "$USERNAMEOFUSER"

sudo npm i -g emmet-ls
mkdir ~/scrot

### XMonad stuff
mkdir -p ~/.cache/xmonad/
mkdir -p ~/.local/share/xmonad/
#sudo cp -r ~/.config/xmonad/pacman-hooks/* /etc/pacman.d/hooks
rm ~/.bash_profile
ln -s ~/.local/repos/dotfiles/home/.config/shell/profile ~/.zprofile
ln -s ~/.local/repos/dotfiles/home/.config/shell/profile ~/.bash_profile
ln -s ~/.local/repos/dotfiles/home/.config/x11/xprofile ~/.xprofile

mkdir -p ~/.local/share/zsh
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

paru -S libxft-bgra

sudo chsh -s /bin/zsh "root"
sudo wget -O /root/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
clear
echo "Everything deployed correctly!"
