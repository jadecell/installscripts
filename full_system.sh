#!/usr/bin/env sh

[ "$(whoami)" = "root" ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1

USERNAME="$(whoami)"
sudo chown -R "$USERNAME":"$USERNAME" ~

echo "Do you want the virtualization suite of applications [y/n]? "
read -r VIRTUALIZATION

echo "Do you want to install (N)eovim or (D)oom Emacs? "
read -r NEOVIMORDOOMEMACS

git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg --noconfirm -si
cd ..
rm -rf paru-bin
sudo sed -i -e "s/#BottomUp/BottomUp/g ; s/#SudoLoop/SudoLoop/g ; s/#UpgradeMenu/UpgradeMenu/g" /etc/paru.conf

sudo mkdir -p /etc/pacman.d/hooks
info "Setting up /etc/pacman.conf and /etc/makepkg.conf and updating sudoers"
CPUTHREADS=$(grep -c processor /proc/cpuinfo)
sudo sed -i -e 's/#Color/Color/g ; s/#VerbosePkgLists/VerbosePkgLists/g' /etc/pacman.conf
sudo sed -i -e 's/#HookDir\ \ \ \ \ =\ \/etc\/pacman.d\/hooks\//HookDir\ \ \ \ \ =\ \/etc\/pacman.d\/hooks\//g' /etc/pacman.conf
sudo sed -i '37i ILoveCandy' /etc/pacman.conf
sudo sed -i -e "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$CPUTHREADS\"/g" /etc/makepkg.conf
sudo sed -i -e "s|#\ Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\"|Defaults\ secure_path=\"/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/home/$USERNAME/.local/bin\"|g" /etc/sudoers

git clone https://gitlab.com/jadecell/dotfiles ~/.local/repos/dotfiles
~/.local/repos/dotfiles/setup

[ "$VIRTUALIZATION" = "y" ] && sudo pacman --needed --noconfirm -S virt-manager qemu libvirt dnsmasq edk2-ovmf ebtables iptables

sudo chsh -s /bin/zsh "$USERNAME"

sudo npm i -g prettier
mkdir ~/scrot

if [ "$VIRTUALIZATION" = "y" ]; then
    sudo systemctl enable --now libvirtd.service
    sudo systemctl enable --now virtlogd.socket
    sudo gpasswd -a "$USERNAME" libvirt
    sudo gpasswd -a "$USERNAME" kvm
    sudo virsh net-autostart default
fi

[ ! -d "$HOME/.local/repos/wallpapers" ] && git clone https://gitlab.com/jadecell/wallpapers.git ~/.local/repos/wallpapers && ln -s ~/.local/repos/wallpapers/29.png ~/.config/wallpaper

### XMonad stuff
# mkdir -p ~/.cache/xmonad/
# mkdir -p ~/.local/share/xmonad/
# sudo cp -r ~/.config/xmonad/pacman-hooks/* /etc/pacman.d/hooks
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

if [ "$NEOVIMORDOOMEMACS" = "n" ]; then

    # Nvim stuff to make installation a little bit easier
    mkdir -p ~/.local/share/nvim/site/pack/packer/start/
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim || exit 1

elif [ "$NEOVIMORDOOMEMACS" = "d" ]; then

    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d/ || exit 1
    ~/.emacs.d/bin/doom -y install

else

    # Nvim stuff to make installation a little bit easier
    mkdir -p ~/.local/share/nvim/site/pack/packer/start/
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim || exit 1

    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d/ || exit 1
    ~/.emacs.d/bin/doom -y install

fi

paru -S libxft-bgra

clear
echo "Everything deployed correctly!"
