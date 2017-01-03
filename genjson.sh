#!/bin/bash

#Get build path
isopath=$(curl -s http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/latest-install-amd64-minimal.txt | tail -n 1 | grep -Eo '^[^/ ]+')

#Get iso filename
isoversion=$(curl -s http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/latest-install-amd64-minimal.txt | tail -n 1 | grep -o 'install.*' | grep -Eo '^[^ ]+')

#Get iso checksum
isochksum=$(curl -s http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/current-install-amd64-minimal/install-amd64-minimal-$isopath.iso.DIGESTS | tail -n 7 | head -n 1 | grep -Eo '^[^ ]+')

#Get stage4 checksum
stage4chksum=$(curl -s http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/current-install-amd64-minimal/stage4-amd64-minimal-$isopath.tar.bz2.DIGESTS | tail -n 7 | head -n 1 | grep -Eo '^[^ ]+')

#Generate 
cat ./virtualbox.json | jq '.variables.install_iso = "'$isoversion'"' | jq '.variables.checksum_iso= "'$isochksum'"' | jq '.variables.stage4_tar = "stage4-amd64-minimal-'$isopath'.tar.bz2"' | jq '.variables.checksum_tar = "'$stage4chksum'"' > virtualboxfinal.json