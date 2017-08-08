#!/bin/bash

cp -f $BASEDIR/kernel/* /mnt/gentoo/tmp/

if [ $MAKE_JOBS -lt 2 ] ; then
    KERNEL_CONFIG="${KERNEL_CONFIG/.smp/}"
fi

KERNEL_PACKAGE="gentoo-sources"
if [[ $KERNEL_CONFIG == *"hardened"* ]] ; then
    KERNEL_PACKAGE="hardened-sources"
fi

chroot /mnt/gentoo /bin/bash <<EOF
emerge --quiet sys-kernel/${KERNEL_PACKAGE}
cd /usr/src/linux
mv /tmp/${KERNEL_CONFIG} .config
make olddefconfig
make -j${MAKE_JOBS}
make install
make modules_install
EOF
