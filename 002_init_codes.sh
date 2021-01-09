#!/bin/sh

tar xvfz data/gumstix_uboot.tgz -C .
. data/env.sh

make distclean -C gumstix_uboot
make gumstix_config -C gumstix_uboot
make all -C gumstix_uboot -j$(nproc)

dd if=/dev/zero of=flash.bin bs=1k count=16k
dd if=gumstix_uboot/u-boot.bin of=flash.bin bs=1k conv=notrunc
