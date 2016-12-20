#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet "=virtual/linux-sources-1"
emerge --quiet "app-emulation/virtualbox-guest-additions"

rc-update add virtualbox-guest-additions default
EOF
