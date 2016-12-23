#!/bin/bash

cp $BASEDIR/kernel.config /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<'EOF'
eselect news read --quiet all
emerge --quiet sys-kernel/gentoo-sources
emerge --quiet sys-kernel/genkernel
cd /usr/src/linux
mv /tmp/kernel.config .config
genkernel --install --symlink --no-zfs --no-btrfs --oldconfig all
emerge --quiet -c sys-kernel/genkernel
EOF
