#!/bin/bash

mount /dev/sda3 /mnt/gentoo

cd /mnt/gentoo
wget --quiet http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage4-amd64-minimal/${STAGE4}
tar xpf ${STAGE4} --xattrs
rm -f ${STAGE4}
