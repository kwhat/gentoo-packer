#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
mkdir /etc/portage/package.keywords
cat > /etc/portage/package.keywords/local.keywords <<'DATA'
app-emulation/virtualbox-guest-additions ~amd64

sys-devel/libtool ~amd64

sys-devel/gcc ~amd64
sys-libs/glibc ~amd64
sys-libs/binutils-libs ~amd64

sys-devel/llvm ~amd64
sys-devel/clang ~amd64
sys-devel/clang-runtime ~amd64
sys-libs/libomp ~amd64
dev-util/cmake ~amd64

app-emulation/maloader ~amd64
dev-libs/opencflite ~amd64
sys-devel/dsymutil-apple ~amd64

sys-libs/libcxxrt ~amd64
sys-libs/libcxx ~amd64
gnustep-base/libobjc2 ~amd64

virtual/jre ~amd64
virtual/jdk ~amd64
dev-java/icedtea ~amd64
dev-java/icedtea-bin ~amd64

sys-devel/crossdev **

sys-devel/automake-wrapper ~amd64
sys-devel/automake ~amd64 
DATA
EOF
