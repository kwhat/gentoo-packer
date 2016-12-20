#!/bin/bash

TARGET=x86_64-w64-mingw32
INSTALL=/opt
FILES=$(pwd)/files

emerge -v sys-devel/crossdev

#crossdev -t ${TARGET}
crossdev -t ${TARGET --g 4.9.2 --genv 'USE="-sanitize"' -P -v

if [ ! -d "${INSTALL}"/windows-jdk-1.6 ] ; then
	tar xzvf "${FILES}"/windows-jdk-1.6.tar.gz -C "${INSTALL}"
fi
