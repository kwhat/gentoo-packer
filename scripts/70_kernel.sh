#!/bin/bash

cp $BASEDIR/kernel.config /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<'EOF'
eselect news read --quiet all
emerge --quiet sys-kernel/gentoo-sources
cd /usr/src/linux
mv /tmp/kernel.config .config
make olddefconfig
make -j8
make modules_install
make install
EOF
