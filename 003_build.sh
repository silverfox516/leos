#!/bin/sh

if [ $# -eq 0 ]; then
	echo Usage: ${0} CHAPTER_NUM
	exit 1
fi

CHAP=$1
DIR_CHAP=navilnux/chap${CHAP}/
DIR_OUT=out

. data/env.sh

if [ -d ${DIR_OUT} ]; then
	rm -rf ${DIR_OUT}
fi

mkdir -p ${DIR_OUT}/navilnuxkernel/boot

echo building chapter ${CHAP} ...
make -C ${DIR_CHAP}

mkimage -A arm -O linux -T kernel -C none -a a0008000 -e a0008000 -n 'Navilnux 0.0.0.1' -d ${DIR_CHAP}/navilnux_gum_img ${DIR_OUT}/navilnuxkernel/boot/uImage
mkfs.jffs2 -e 0x20000 -d ${DIR_OUT}/navilnuxkernel -p -o ${DIR_OUT}/navilnux.jffs2

dd of=navilnuximg bs=1k count=16k if=/dev/zero 
dd of=navilnuximg bs=1k conv=notrunc if=gumstix_uboot/u-boot.bin
dd of=navilnuximg bs=1k conv=notrunc seek=180 if=${DIR_OUT}/navilnux.jffs2
