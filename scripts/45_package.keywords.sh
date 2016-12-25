#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
cat > /etc/portage/package.keywords/local.keywords <<'DATA'
app-emulation/virtualbox-guest-additions ~amd64
DATA
EOF
