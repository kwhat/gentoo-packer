#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet --sync
emerge --quiet --update --deep --newuse world

etc-update --quiet --automode -5
EOF
