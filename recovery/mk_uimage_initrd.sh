#!/bin/bash
#
# Copyright (C) 2012, fredvj
#

set -x

# Set the required folders

OUTDIR=../../../../out/target/product/uboot1
OUTFILE=uInitrd
RECOVERYROOT=${OUTDIR}/recovery/root
RECOVERYRAMDISK=ramdisk-recovery.cpio

# Create the CPIO.gz file

if [ -e ${OUTDIR}/${OUTFILE} ]; then
  rm ${OUTDIR}/${OUTFILE}
fi

if [ -e ${OUTDIR}/${RECOVERYRAMDISK}.gz ]; then
  rm ${OUTDIR}/${RECOVERYRAMDISK}.gz
fi

cat ${OUTDIR}/${RECOVERYRAMDISK} | gzip > ${OUTDIR}/${RECOVERYRAMDISK}.gz

mkimage -A arm -O linux -T ramdisk -C gzip -a 0 -e 0 -n "Recovery INITRAMFS Image" -d "${OUTDIR}/${RECOVERYRAMDISK}.gz" "${OUTDIR}/uInitrd"
