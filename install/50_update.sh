#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet --sync
emerge --quiet --update --deep --newuse world
EOF
