#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet crossdev
EOF
