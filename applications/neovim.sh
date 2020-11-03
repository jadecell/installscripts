#!/usr/bin/env sh

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

# Install dotfiles if not already installed
! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/

if [[ "$DISTRO" = "arch" ]]; then
    sudo pacman --needed --noconfirm -S neovim python-pynvim nodejs npm yarn
else
    sudo emerge --autounmask-continue app-editors/neovim dev-python/pip net-libs/nodejs sys-apps/yarn
    pip3 install --user pynvim
fi

cp -r $HOME/dotfiles/.config/nvim/ $HOME/.config/

echo
echo "--------INSTALLED NEOVIM--------"
echo

exit 0
