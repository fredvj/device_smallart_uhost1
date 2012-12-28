#!/bin/bash
set -x

# Set the required folders

OUTDIR=../../../../out/target/product/uboot1
KERNELDIR=../../../../kernel/allwinner/common

# As we ask make to go to KERNELDIR, the following folders are relativ to it

# KERNELCONFIG=sun4i_crane_defconfig
KERNELCONFIG=uboot1_recovery_defconfig
RECOVERYROOTDIR=../../../out/target/product/uboot1/recovery/root
TOOLCHAIN=../../../prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

# Cleanup kernel directory

make -C $KERNELDIR ARCH=arm CROSS_COMPILE=$TOOLCHAIN mrproper

# Copy defconfig for recovery

cp $KERNELCONFIG "${KERNELDIR}/arch/arm/configs"

# Run defconfig

make -C $KERNELDIR ARCH=arm CROSS_COMPILE=$TOOLCHAIN defconfig $KERNELCONFIG

# Make the kernel modules

make -C $KERNELDIR ARCH=arm CROSS_COMPILE=$TOOLCHAIN zImage modules

# Install modules

make -C $KERNELDIR ARCH=arm CROSS_COMPILE=$TOOLCHAIN INSTALL_MOD_PATH=${RECOVERYROOTDIR}/system modules_install

# Make the kernel & include recovery as initramfs

make -C $KERNELDIR ARCH=arm CROSS_COMPILE=$TOOLCHAIN CONFIG_INITRAMFS_SOURCE="$RECOVERYROOTDIR" zImage

# Run mkimage to create an uImage

mkimage -A arm -O linux -T kernel -C none -a 40008000 -e 40008000 -n "Android Recovery Kernel Image" -d "${KERNELDIR}/arch/arm/boot/zImage" "${OUTDIR}/uImage_recovery"
