#!/bin/bash

TARGET=armv7a-hardfloat-linux-gnueabihf
#INSTALL=/opt
#FILES=$(pwd)/files


#emerge -v sys-devel/crossdev
#crossdev -C -t ${TARGET}
#crossdev -t ${TARGET}

#rm /usr/${TARGET}/etc/portage/make.profile
#ln -s /usr/portage/profiles/default/linux/arm/13.0 /usr/${TARGET}/etc/portage/make.profile

${TARGET}-emerge -av =sys-libs/ncurses-5.9-r4
CFLAGS=-L/usr/${TARGET}/usr/lib CXXFLAGS=-L/usr/${TARGET}/usr/lib ${TARGET}-emerge -av util-linux

${TARGET}-emerge -av xcb-proto
${TARGET}-emerge -av libXt libXtst libXinerama libxkbcommon libxkbfile libxcb
