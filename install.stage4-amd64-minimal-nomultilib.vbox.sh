#!/bin/bash

MIRROR="http://gentoo.ussg.indiana.edu/releases"

# Get the variant string from the file name.
file_name=${0##*/}
variant=$(awk -F'[.]' '{print $2}' <<< ${file_name%.*})
arch=$(awk -F'[-]' '{print $2}' <<< ${variant%.*})
vm_host=$(awk -F'[.]' '{print $3}' <<< ${file_name%.*})

# Get the latest ISO location and checksum.
iso_file=$(curl -s ${MIRROR}/${arch}/autobuilds/latest-install-${arch}-minimal.txt | tail -n 1 | grep -o '^\S*')
iso_chksum=$(curl -s ${MIRROR}/${arch}/autobuilds/${iso_file}.DIGESTS | sed -n '/SHA512/{n;p;}' | grep "${iso_file##*/}$" | grep -o '^\S*')

# Get the latest stage variant and checksum.
stage_file=$(curl -s ${MIRROR}/${arch}/autobuilds/latest-${variant}.txt | tail -n 1 | grep -o '^\S*')
stage_chksum=$(curl -s ${MIRROR}/${arch}/autobuilds/${stage_file}.DIGESTS | sed -n '/SHA512/{n;p;}' | grep "${stage_file##*/}\$" | grep -o '^\S*')

echo $iso_file
echo $iso_chksum

echo $stage_file
echo $stage_chksum

echo $vm_host
exit

packer build -only=virtualbox-iso -var "aws_access_key=foo" virtualbox.json
