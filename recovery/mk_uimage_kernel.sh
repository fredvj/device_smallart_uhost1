#!/bin/bash
#
# Copyright (C) 2012, fredvj
#

set -x

# Set the required folders

OUTDIR=../../../../out/target/product/uhost1
KERNELDIR=../prebuilt

# Run mkimage to create an uImage

mkimage -A arm -O linux -T kernel -C none -a 40008000 -e 40008000 -n "Android Kernel Image" -d "${KERNELDIR}/kernel" "${OUTDIR}/uImage"
