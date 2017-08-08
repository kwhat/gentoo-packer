#!/bin/bash

# Config options
MIRROR="http://gentoo.ussg.indiana.edu"

# Get the variant string from the file name.
file_name=${0##*/}
variant=$(awk -F'[.]' '{print $1}' <<< ${file_name%.*})
arch=$(awk -F'[-]' '{print $2}' <<< ${variant%.*})
vm_type=$(awk -F'[.]' '{print $2}' <<< ${file_name%.*})
base_uri="releases/${arch}/autobuilds"

# Get the latest ISO location and checksum.
iso_file=$(curl -s ${MIRROR}/${base_uri}/latest-install-${arch}-minimal.txt | tail -n 1 | grep -o '^\S*')
iso_checksum=$(curl -s ${MIRROR}/${base_uri}/${iso_file}.DIGESTS | sed -n '/SHA512/{n;p;}' | grep "${iso_file##*/}$" | grep -o '^\S*')

# Get the latest stage variant and checksum.
stage_file=$(curl -s ${MIRROR}/${base_uri}/latest-${variant}.txt | tail -n 1 | grep -o '^\S*')
stage_checksum=$(curl -s ${MIRROR}/${base_uri}/${stage_file}.DIGESTS | sed -n '/SHA512/{n;p;}' | grep "${stage_file##*/}\$" | grep -o '^\S*')

packer build \
	-force \
	-only=${vm_type}-iso \
	-var "mirror=${MIRROR}" \
	-var "iso_file=${base_uri}/${iso_file}" \
	-var "iso_checksum=${iso_checksum}" \
	-var "stage_file=${base_uri}/${stage_file}" \
	-var "stage_checksum=${stage_checksum}" \
	-var "kernel_config=kernel/hardened-sources.smp.config" \
	-var "vm_name=Gentoo 64 Hardened Base" \
	-var "vm_description=Gentoo 64 Hardened Base Install" \
	-var "vm_typ=Gentoo_64" \
	-var "vm_cpus=8" \
	-var "vm_memory=4096" \
	-var "vm_cflags=-march=x86-64 -mtune=generic -O2 -D_FORTIFY_SOURCE=2 -fomit-frame-pointer -fstack-protector-strong --param ssp-buffer-size=4 -pipe" \
	gentoo.json
