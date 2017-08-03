#!/bin/bash

cp -Rf $BASEDIR/kernel /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<EOF
emerge --quiet sys-kernel/gentoo-sources
#emerge --quiet sys-kernel/hardened-sources
cd /usr/src/linux
mv /tmp/kernel/gentoo-smp.config .config
make olddefconfig
make -j${MAKE_JOBS}
make install
make modules_install
EOF
