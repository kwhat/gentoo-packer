#!/bin/bash

cd /mnt/gentoo
wget ${MIRROR}/snapshots/portage-latest.tar.xz
tar xpf portage-latest.tar.xz -C usr/ --warning=no-timestamp
rm -f portage-latest.tar.xz
