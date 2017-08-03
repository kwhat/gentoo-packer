#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge-webrsync
emerge --quiet net-dialup/mingetty
#emerge --quiet --update --deep --newuse world
#etc-update --quiet --automode -5
eselect news read --quiet all
EOF
