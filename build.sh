#!/bin/bash

export ARCH=arm64

KERNEL_SOURCE_DIR="$(pwd)"
OUTPUT_DIR="$(pwd)/kout"
CONFIG_FILE="$(pwd)/arch/arm64/configs/zeroflte_02_defconfig"
CROSS_COMPILE="/home/chanz22/tc/gcc-linaro-6.4.1/bin/aarch64-linux-gnu-" 
JOBS=$(nproc)

if [ ! -d "$KERNEL_SOURCE_DIR" ]; then
    echo "Error: Kernel source not found in $KERNEL_SOURCE_DIR"
    exit 1
fi

cd "$KERNEL_SOURCE_DIR" || exit

make  mrproper

make O="$OUTPUT_DIR" zeroflte_02_defconfig

make -j"$JOBS" O="$OUTPUT_DIR" CROSS_COMPILE="$CROSS_COMPILE" Image modules dtbs

if [ $? -ne 0 ]; then
    echo "Error: kernel stuck in compilation!"
    exit 1
fi

echo "done"
