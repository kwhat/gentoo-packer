#!/bin/bash

mount /dev/sda4 /mnt/gentoo

cd /mnt/gentoo
wget --show-progress --quiet ${MIRROR}/${STAGE_FILE}
tar xpf $(basename ${STAGE_FILE}) --xattrs
rm -f $(basename ${STAGE_FILE})
