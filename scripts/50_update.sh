#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge-webrsync
emerge --quiet --update --deep --newuse world
etc-update --quiet --automode -5
EOF
