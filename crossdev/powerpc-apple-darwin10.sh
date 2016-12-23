#!/bin/bash
# Based on files and patches from:
# https://launchpad.net/~flosoft/+archive/cross-apple/+packages

TARGET=powerpc-apple-darwin10
PREFIX=/opt/apple-sdk/usr

SDKROOT="${PREFIX}"/lib/apple/SDKs/MacOSX10.5.sdk
SDKLIB="libstdc++.6.0.4.dylib"

#SDKROOT="${PREFIX}"/lib/apple/SDKs/MacOSX10.6.sdk
#SDKLIB="libstdc++.6.0.9.dylib"

FILES=$(pwd)/files

export PATH="${PATH}:${PREFIX}/bin" 

# Begin odcctools
rm -Rvf /tmp/apple-x86-gcc-4.2.1 /tmp/apple-x86-odcctools-758.159
rm -Rvf "${PREFIX}"/${TARGET}
mkdir -p "${PREFIX}"/${TARGET}

if [ ! -f /tmp/apple-x86-odcctools_758.159.tar.gz ] ; then
	wget https://launchpad.net/~flosoft/+archive/cross-apple/+files/apple-x86-odcctools_758.159-0flosoft11.tar.gz -O /tmp/apple-x86-odcctools_758.159.tar.gz
fi
tar xzvf /tmp/apple-x86-odcctools_758.159.tar.gz -C /tmp
cd /tmp/apple-x86-odcctools-758.159

patch -p1 < debian/patches/as.patch && \
patch -p1 < debian/patches/objc.patch && \
patch -p1 < debian/patches/vm_types_h.patch && \
patch -p1 < debian/patches/arch_c.patch && \
patch -p0 < "${FILES}"/apple-x86-odcctools-758.159_ld64.patch || exit 1

mkdir build
cd build

CFLAGS="-fno-stack-protector" CXXFLAGS="-fno-stack-protector" \
../configure \
	--target=${TARGET} \
	--prefix="${PREFIX}" \
	--with-sysroot="${SDKROOT}" \
	--datarootdir=${PREFIX}/${TARGET}/share \
	--localedir=${PREFIX}/${TARGET}/share/locale \
	--includedir=${PREFIX}/${TARGET}/include \
	--libdir=${PREFIX}/${TARGET}/lib \
	--libexecdir=${PREFIX}/${TARGET}/lib \
	--bindir=${PREFIX}/bin && \
make -j$(cat /proc/cpuinfo | grep processor | wc -l) && \
make install || exit 1



# Begin apple-gcc-4.2.1-5646
if [ ! -f /tmp/apple-x86-gcc_4.2.1~5646.tar.gz ] ; then 
	wget https://launchpad.net/~flosoft/+archive/cross-apple/+files/apple-x86-gcc_4.2.1~5646.1flosoft2.tar.gz -O /tmp/apple-x86-gcc_4.2.1~5646.tar.gz
fi
tar -xzvf /tmp/apple-x86-gcc_4.2.1~5646.tar.gz -C /tmp
cd /tmp/apple-x86-gcc-4.2.1

tar -xzvf gcc-5646.1.tar.gz
mkdir -p gcc-build
cd /tmp/apple-x86-gcc-4.2.1/gcc-build

cp -Rvf ../debian/patches .
sed -i "s#%%prefix%%#${PREFIX}/${TARGET}#g;s#%%target%%#${TARGET}#g;s#%%sysroot%%#${PREFIX}/${TARGET}#g;s#%%sdkdir%%#${SDKROOT}#g" ./patches/*.patch
cd ../gcc-5646.1 && \
patch -p1 < ../gcc-build/patches/t-darwin.patch && \
patch -p1 < ../gcc-build/patches/t-darwin_rs6000.patch && \
patch -p1 < ../gcc-build/patches/driverdriver_c.patch && \
patch -p1 < ../gcc-build/patches/darwin-driver_c.patch && \
patch -p1 < ../gcc-build/patches/darwin_h.patch || exit 2

#--with-gxx-include-dir=${SDKROOT}/usr/include/c++/4.2.1 \
#--enable-languages=c,c++,objc,obj-c++ \

cd /tmp/apple-x86-gcc-4.2.1/gcc-build
../gcc-5646.1/configure \
	--target=${TARGET} \
	--prefix="${PREFIX}" \
	--with-sysroot="${SDKROOT}" \
	--with-slibdir=${PREFIX}/${TARGET}/lib \
	--mandir=${PREFIX}/${TARGET}/share/man \
	--infodir=${PREFIX}/${TARGET}/share/info \
	--libexecdir=${PREFIX}/lib \
	--disable-nls \
	--with-gxx-include-dir=/usr/lib64/gcc/x86_64-pc-linux-gnu/4.5.3/include/g++-v4 \
	--enable-languages=c,c++ \
	--enable-version-specific-runtime-libs \
	--with-as=${PREFIX}/bin/${TARGET}-as \
	--with-ld=${PREFIX}/bin/${TARGET}-ld && \
rm -vf GNUmakefile && \
make -j$(cat /proc/cpuinfo | grep processor | wc -l) && \
make install || exit 2

rm -vf ${PREFIX}/${TARGET}/lib/libiberty.a
mkdir -p ${PREFIX}/lib/gcc/${TARGET}/4.2.1
ln -sfv ${SDKROOT}/usr/lib/${SDKLIB} ${PREFIX}/lib/gcc/${TARGET}/4.2.1/${SDKLIB}
ln -sfv ${SDKLIB} $(DESTDIR)$(prefix)/lib/gcc/${TARGET}/4.2.1/libstdc++.6.dylib
ln -sfv libstdc++.6.dylib ${PREFIX}/lib/gcc/${TARGET}/4.2.1/libstdc++.dylib


mkdir -vp ${PREFIX}/${TARGET}/bin && \
for file in $(ls ${PREFIX}/bin/${TARGET}-*) ; do
        ln -sfv ../../bin/$(basename $file) ${PREFIX}/${TARGET}/bin/$(basename $file | sed "s/${TARGET}-//g")
done
