#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
sed -i 's/^#\s*%wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
EOF
