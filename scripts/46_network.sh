#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
ln -s /etc/init.d/net.lo /etc/init.d/net.eth0
echo 'config_eth0="dhcp"' >> /etc/conf.d/net
rc-update add net.eth0 default
touch /etc/udev/rules.d/80-net-name-slot.rules
rc-update add sshd default
EOF
