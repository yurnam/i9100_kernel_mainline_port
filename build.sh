#!/bin/bash

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

DTB=exynos4210-i9100.dtb
COMB_ZIMAGE=zImage-dtb
DEFCONFIG=i9100_defconfig



mkdir -p ../images
mkdir -p ../rootfs



if [ -f ".config" ]; then
    make xconfig
else 
    make $DEFCONFIG
fi

make -j$(nproc)

cat arch/arm/boot/zImage arch/arm/boot/dts/$DTB > $COMB_ZIMAGE
mkimage -A arm -O linux -T kernel -C none -a 0x40008000 -e 0x40008000 -d $COMB_ZIMAGE ../images/recovery.img

#dd if=/dev/zero of=./modules.img bs=1M count=50
#mkfs.ext4 modules.img
rm -rf MODTEMP
mkdir MODTEMP
#mount modules.img MODTEMP
make modules_install INSTALL_MOD_PATH=./MODTEMP INSTALL_MOD_STRIP=1
make modules_install INSTALL_MOD_PATH=../rootfs/ INSTALL_MOD_STRIP=1

if [ -d "MODTEMP/lib/modules" ]; then
	mv MODTEMP/lib/modules/$(ls MODTEMP/lib/modules/)/* MODTEMP/
	rm -rf MODTEMP/lib
	#umount MODTEMP
	make_ext4fs -s -l 200M modules.img MODTEMP	
	mv modules.img ../images/
	

fi











