#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet "sys-boot/grub:2"
etc-update --quiet --automode -5
echo "set timeout=10" >> /etc/grub.d/40_custom
grub-install /dev/sda
sed -i 's/^#\s*GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="net.ifnames=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
EOF
