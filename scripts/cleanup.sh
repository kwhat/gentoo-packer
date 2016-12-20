#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
cd /usr/src/linux && make clean
emerge --quiet  -C sys-kernel/gentoo-sources
emerge --quiet --depclean
EOF

rm -rf /mnt/gentoo/usr/portage
rm -rf /mnt/gentoo/tmp/*
rm -rf /mnt/gentoo/var/log/*
rm -rf /mnt/gentoo/var/tmp/*

#chroot /mnt/gentoo /bin/bash <<'EOF'
#wget http://intgat.tigress.co.uk/rmy/uml/zerofree-1.0.3.tgz
#tar xvzf zerofree-*.tgz
#cd zerofree*/
#make
#EOF

#mv /mnt/gentoo/zerofree* ./
#cd zerofree*/

mount -o remount,ro /mnt/gentoo
#./zerofree /dev/sda4

swapoff /dev/sda2
