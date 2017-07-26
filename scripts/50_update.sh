#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge-webrsync --quiet
emerge --quiet --update --deep --newuse world

etc-update --quiet --automode -5
EOF
