#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --verbose layman

echo "conf_type : make.conf" > /etc/layman/layman.cfg
mkdir -p /etc/layman/overlays/ && cd /etc/layman/overlays/
wget --quiet https://raw.githubusercontent.com/kwhat/crossdev-apple-overlay/master/metadata/crossdev-apple.xml
layman -a crossdev-apple
layman -S
EOF
