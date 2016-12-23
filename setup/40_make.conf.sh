#!/bin/shscripts/

chroot /mnt/gentoo /bin/bash <<'EOF'

cat > /etc/portage/make.conf <<'DATA'

source /var/lib/layman/make.conf

LLVM_TARGETS="ARM PowerPC Sparc X86"
DATA
EOF 
