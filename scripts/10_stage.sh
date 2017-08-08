#!/bin/bash

mount /dev/sda4 /mnt/gentoo

cd /mnt/gentoo
wget ${MIRROR}/${STAGE_FILE}
tar xpf $(basename ${STAGE_FILE}) --xattrs --numeric-owner
rm -f $(basename ${STAGE_FILE})
