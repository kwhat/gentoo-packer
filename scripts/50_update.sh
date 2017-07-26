#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge-webrsync --quiet
emerge --quiet --update --deep --newuse world
EOF
