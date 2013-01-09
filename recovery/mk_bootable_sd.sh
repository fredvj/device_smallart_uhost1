#!/bin/bash

# set -x

logfile=create.log

checkSyntax() {
	if [ -z $1 ]; then
		echo "Usage: $0 [device]"
		exit 1
	fi

	if [ ! -e $1 ]; then
		echo "Invalid device: $1"
		exit 1
	fi
}

umountSD() {
	partlist=`mount | grep $1 | awk '{ print $1 }'`
	for part in $partlist
	do
		sudo umount $part
	done
}

partitionSD() {
    devicename=${1##/*/}
    subdevice=$1;
    if [ ${devicename:0:6} = "mmcblk" ]; then
        subdevice="${1}p"
    fi

    if [ ${devicename:0:4} = "loop" ]; then
        subdevice="${1}p"
    fi

	echo "Delete Existing Partition Table"
	sudo dd if=/dev/zero of=$1 bs=1M count=1 >> ${logfile} 

	echo "Creating Partitions"
	sudo parted $1 --script mklabel msdos >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to create label for $1"
		exit 1
	fi 

	echo "Partition 1 - ${subdevice}1"
	sudo parted $1 --script mkpart primary fat32 2048s 16MB >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to create ${subdevice}1 partition" 
		exit 1
	fi 

	vfat_end=`sudo fdisk -lu $1 | grep ${subdevice}1 | awk '{ print $3 }'`
	ext4_offset=`expr $vfat_end + 1`
	echo "Partition 2 (Starts at sector No. $ext4_offset)"
	sudo parted $1 --script mkpart primary fat32 ${ext4_offset}s -- -1 >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to create ${subdevice}2 partition"
		exit 1
	fi 

	echo "Format Partition 1 to VFAT"
	sudo mkfs.vfat -I ${subdevice}1 >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to format ${subdevice}1 partition"
		exit 1
	fi 

	echo "Format Partition 2 to VFAT"
	sudo mkfs.vfat  ${subdevice}2 >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to format ${subdevice}2 partition"
		exit 1
	fi 
}

copyUbootSpl()
{	
	echo "Copy U-Boot SPL to SD Card"
	sudo dd if=$2 bs=1024 of=$1 seek=8
}

copyUboot()
{	
	echo "Copy U-Boot to SD Card"
	sudo dd if=$2 bs=1024 of=$1 seek=32
}

mountPartitions() {
    devicename=${1##/*/}
    subdevice=$1;
    if [ ${devicename:0:6} = "mmcblk" ]; then
        subdevice="${1}p"
    fi

    if [ ${devicename:0:4} = "loop" ]; then
        subdevice="${1}p"
    fi

	echo "Mount SD card partitions"
	mkdir -p mntSDvfat >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to create SD card mount points"
		cleanup
	fi 

	echo "Mount VFAT Parition (SD)" 
	sudo mount ${subdevice}1 mntSDvfat >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to mount VFAT partition (SD)"
		cleanup
	fi
}

umountPart() {
	if [ -d $1 ]; then
		mounted=`mount | grep $1`
		if [ ! -z mounted ]; then
			echo "Umount $2"
			sudo umount $1 >> ${logfile}
			if [ $? -ne 0 ]; then
				echo "Failed to umount $2)"
			else
				echo "Delete $1"
				rm -rf $1 >> ${logfile}
			fi
		else
			echo "Delete $1"
			rm -rf $1 >> ${logfile}
		fi	 
	fi
}

copyData() {
	echo "Copy kernel image to SD Card"
	sudo cp ../prebuilt/uImage mntSDvfat >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to copy kernel image to SD Card"
		cleanup
	fi 

	echo "Copy Initial RAM Disk to SD Card"
	sudo cp ../prebuilt/uInitrd mntSDvfat >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to copy Initial RAM Disk to SD card"
		cleanup
	fi

	echo "Copy Device Initialization to SD Card"
	sudo cp ../prebuilt/script.bin mntSDvfat >> ${logfile}
	if [ $? -ne 0 ]; then
		echo "Failed to copy Device Initialization to SD Card"
		cleanup
	fi

	if [ -f ../prebuilt/boot.scr ]; then 
		echo "Copy U-Boot startup script image to SD Card"
		sudo cp ../prebuilt/boot.scr mntSDvfat >> ${logfile}
		if [ $? -ne 0 ]; then
			echo "Failed to copy U-Boot startup script image to SD Card"
			cleanup
		fi
	fi
}

cleanup() {
	umountPart mntSDvfat "VFAT Partition (SD)"
}

# Call the different functions

echo "$0 log file" > ${logfile} 
checkSyntax $1
umountSD $1
partitionSD $1
copyUbootSpl $1 ../prebuilt/u-boot/sunxi-spl.bin
copyUboot $1 ../prebuilt/u-boot/u-boot.bin
mountPartitions $1
copyData 
cleanup

exit 0
