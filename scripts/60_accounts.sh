#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
echo "root:vagrant" | chpasswd
useradd -m -G users,wheel -s /bin/bash vagrant
echo "vagrant:vagrant" | chpasswd
su - vagrant -c "wget -O ~/.ssh/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub"
su - vagrant -c "chmod 0600 ~/.ssh/authorized_keys"
EOF
