#!/bin/sh

# for emulator boot with u-boot only
#qemu-system-arm -M connex -pflash flash.bin -nographic

qemu-system-arm -M connex -pflash navilnuximg -nographic
