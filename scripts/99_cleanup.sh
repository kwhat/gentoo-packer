#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
cd /usr/src/linux && make clean
emerge --quiet  -C sys-kernel/gentoo-sources
emerge --quiet --depclean
EOF

rm -rf /mnt/gentoo/usr/portage/distfiles/*
rm -rf /mnt/gentoo/tmp/*
rm -rf /mnt/gentoo/var/log/*
rm -rf /mnt/gentoo/var/tmp/*

mount -o remount,ro /mnt/gentoo

swapoff /dev/sda3
