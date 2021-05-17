#!/usr/bin/env sh

# Run the current script as root with all the arguments if not already being ran as root
if [ "$(id -u)" -ne "0" ]; then exec sudo "$0" "$@"; fi

# For Xorg
# https://wiki.gentoo.org/wiki/Xorg/Guide

emerge app-eselect/eselect-repository
mkdir -p /etc/portage/repos.conf
eselect repository enable menelkir src_prepare-overlay thegreatmcpain bobwya guru go-overlay
eix-sync

curl -fsSL https://starship.rs/install.sh | bash

echo '## Xorg Configuration' >> /etc/portage/make.conf
echo 'VIDEO_CARDS="nouveau"' >> /etc/portage/make.conf
echo 'INPUT_DEVICES="libinput"' >> /etc/portage/make.conf

emerge --keep-going --noreplace --autounmask-continue x11-base/xorg-x11 media-fonts/joypixels www-client/firefox app-shells/fzf x11-misc/xwallpaper media-gfx/sxiv sys-apps/lsd net-libs/nodejs lxde-base/lxappearance x11-misc/xclip app-text/zathura app-text/zathura-pdf-poppler media-video/mpv x11-misc/dunst media-sound/pulseaudio media-sound/pamixer media-sound/pavucontrol media-sound/playerctl lxde-base/lxsession app-arch/unzip app-arch/zip app-misc/jq sys-power/acpi media-fonts/nerd-fonts sys-devel/bc x11-misc/trayer x11-misc/xcompmgr app-admin/sysstat media-gfx/scrot media-fonts/cantarell app-editors/emacs sys-apps/bat sys-apps/lm-sensors sys-apps/ripgrep sys-apps/fd x11-misc/xdo media-fonts/ubuntu-font-family dev-vcs/lazygit dev-util/shfmt kitty
