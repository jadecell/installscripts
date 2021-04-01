#!/usr/bin/env sh

# For Xorg
# https://wiki.gentoo.org/wiki/Xorg/Guide
 
# overlays added: menelkir src_prepare-overlay thegreatmcpain bobwya
sudo emerge app-eselect/eselect-repository
sudo mkdir -p /etc/portage/repos.conf
sudo eselect repository enable menelkir src_prepare-overlay thegreatmcpain bobwya
sudo eix-sync

git clone https://gitlab.com/et-8/glarbs-deploy
sudo mkdir -p /etc/portage/patches/x11-libs/libXft
sudo cp glarbs-deploy/etc/portage/patches/x11-libs/libXft/*.patch /etc/portage/patches/x11-libs/libXft/
sudo emerge x11-libs/libXft
rm -rf glarbs-deploy

eselect news read >/dev/null 2>&1

curl -fsSL https://starship.rs/install.sh | bash

sudo flaggie firefox +hwaccel
sudo flaggie thunderbird +hwaccel
sudo flaggie xwallpaper +jpeg +png
sudo flaggie sxiv +gif +exif
sudo flaggie libreoffice -branding
sudo flaggie sysstat +lm-sensors
sudo flaggie nerd-fonts +hack +firacode
sudo flaggie emacs +gui +tiff +png +xwidgets
sudo flaggie clang-runtime -sanitize

sudo emerge --autounmask-continue x11-base/xorg-x11 media-fonts/joypixels www-client/firefox app-shells/fzf x11-misc/xwallpaper media-gfx/sxiv sys-apps/lsd net-libs/nodejs lxde-base/lxappearance x11-misc/xclip app-text/zathura app-text/zathura-pdf-poppler media-video/mpv x11-misc/dunst media-sound/pulseaudio media-sound/pamixer media-sound/pavucontrol media-sound/playerctl app-misc/ranger dev-libs/libvterm mail-client/thunderbird lxde-base/lxsession app-arch/unzip app-arch/zip app-office/libreoffice app-misc/jq sys-power/acpi media-fonts/nerd-fonts sys-devel/bc x11-misc/trayer x11-misc/xcompmgr app-admin/sysstat media-gfx/scrot media-fonts/cantarell app-editors/emacs sys-apps/bat sys-apps/lm-sensors sys-apps/ripgrep sys-apps/fd x11-misc/xdo media-fonts/ubuntu-font-family net-misc/nextcloud-client
