#!/bin/sh

chroot /mnt/gentoo /bin/bash <<'EOF'
cat > /etc/portage/make.conf <<DATA
CHOST="x86_64-pc-linux-gnu"
CFLAGS="${MAKE_FLAGS}"
CXXFLAGS="\${CFLAGS}"
MAKEOPTS="-j${MAKE_JOBS}"
FEATURES="parallel-fetch"
EMERGE_DEFAULT_OPTS="--with-bdeps=y --jobs=${MAKE_JOBS} --load-average=$(echo ${MAKE_JOBS} \* 1.2 | bc)"

ABI_X86="64 32"
PORTAGE_NICENESS="0"
LINGUAS="en en_US"

ACCEPT_LICENSE="*"
PORTDIR="/usr/portage"

USE="-alsa -kde -qt -gnome -gtk -ldap -python -perl -fortran -X -ipv6 -cups -spell -berkdb mmx sse minimal urandom"
USE="${USE} -apache -apache2 -mysql -samba -cifs -subversion berkdb unicode"
USE="${USE} -antlr -bsf -commonslogging -commonsnet -javamail -jsch -log4j"
USE="${USE} python2 -python3"

USE_PYTHON="2.7"
PYTHON_TARGETS="python2_7"
PYTHON_SINGLE_TARGET="python2_7"
DATA
EOF
