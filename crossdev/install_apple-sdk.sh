#!/bin/bash

PREFIX=/opt/apple-sdk/usr
INSTALL=${PREFIX}/lib/apple/SDKs
FILES=$(pwd)/files

rm -Rvf "${INSTALL}"
mkdir -p "${INSTALL}"/Library/Frameworks

tar xzvf "${FILES}"/apple-sdk-10.4u.tar.gz -C "${INSTALL}"
ln -sfv ../../Library/Frameworks "${INSTALL}"/MacOSX10.4u.sdk/Library/Frameworks

tar xzvf "${FILES}"/apple-sdk-10.5.tar.gz -C "${INSTALL}"
ln -sfv ../../Library/Frameworks "${INSTALL}"/MacOSX10.5.sdk/Library/Frameworks

tar xzvf "${FILES}"/apple-sdk-10.6.tar.gz -C "${INSTALL}"
ln -sfv ../../Library/Frameworks "${INSTALL}"/MacOSX10.6.sdk/Library/Frameworks

chown -R root:root "${INSTALL}"
