#!/bin/bash

#emerge -v app-emulation/emul-linux-x86-baselibs app-emulation/emul-linux-x86-xlibs

TARGET=i686-pc-linux-gnu
#INSTALL=/opt
#FILES=$(pwd)/files

emerge -v sys-devel/crossdev

crossdev -t ${TARGET}

rm /usr/${TARGET}/etc/portage/make.profile
ln -s /usr/portage/profiles/default/linux/x86/13.0 /usr/${TARGET}/etc/portage/make.profile
${TARGET}-emerge -av xcb-proto
${TARGET}-emerge -av libXt libXtst libXinerama  libxkbcommon libxkbfile libxcb
