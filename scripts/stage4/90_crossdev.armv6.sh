#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
crossdev -t armv6j-hardfloat-linux-gnueabihf
rm /usr/armv6j-hardfloat-linux-gnueabihf/etc/portage/make.profile
ln -s /usr/portage/profiles/default/linux/arm/13.0 /usr/armv6j-hardfloat-linux-gnueabihf/etc/portage/make.profile
armv6j-hardfloat-linux-gnueabihf-emerge -av =sys-libs/ncurses-5.9-r4
CFLAGS=-L/usr/armv6j-hardfloat-linux-gnueabihf/usr/lib CXXFLAGS=-L/usr/armv6j-hardfloat-linux-gnueabihf/usr/lib armv6j-hardfloat-linux-gnueabihf-emerge -av util-linux
armv6j-hardfloat-linux-gnueabihf-emerge -av xcb-proto
armv6j-hardfloat-linux-gnueabihf-emerge -av libXt libXtst libXinerama libxkbcommon libxkbfile libxcb
EOF
