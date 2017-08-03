#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet app-admin/sudo
sed -i 's/^#\s*%wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
EOF
