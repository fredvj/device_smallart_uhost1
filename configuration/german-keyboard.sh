#!/system/xbin/busybox sh

# Copyright (C) 2013, fredvj
#
# Script to install the Key Character Map (KCM) & Key Layout (KL)
# files for a German keyboard
#

# set -x

BASEPATH=/data/system/devices
KCM=keychars
KL=keylayout
KCM_SOURCE=/system/usr/keychars/qwertz.kcm
KL_SOURCE=/system/usr/keylayout/qwertz.kl
LSUSB1=/cache/lsusb.1
LSUSB2=/cache/lsusb.2
LSUSBDIFF=/cache/lsusb.diff

# First, create the directories

mkdir -p ${BASEPATH}/${KCM}

if [ "$?" != "0" ]
then
	echo "Failed to create folder for KCM files"
	exit 1
fi

mkdir -p ${BASEPATH}/${KL}

if [ "$?" != "0" ]
then
	echo "Failed to create folder for KL files"
	exit 1
fi

# Second step is to check our source files

if [ ! -f $KCM_SOURCE ]
then
	echo "Key Character Map (KCM) file does not exist: $KCM_SOURCE"
	exit 1
fi

if [ ! -f $KL_SOURCE ]
then
	echo "Keyboard Layout (KL) file does not exist: $KL_SOURCE"
	exit 1
fi

# Write back status of currently connected USB devices

lsusb > $LSUSB1
lsusb > $LSUSB2

if [ "$?" != "0" ]
then
	echo "Failed to write list of connected USB devices."
	exit 1
fi

# Inform the user that we are waiting for his action

echo .
echo "**********************************************************"
echo "**                                                      **"
echo "**  PLEASE READ                                         **"
echo "**                                                      **"
echo "**  Please disconnect your USB keyboard now             **"
echo "**  The script will try to detect it                    **"
echo "**                                                      **"
echo "**********************************************************"
echo .
echo -n "Waiting "

# Wait until the USB status files differ

diff -U 0 $LSUSB1 $LSUSB2 > $LSUSBDIFF

while [ "$?" = "0" ]
do
	sleep 1
	echo -n "."
	lsusb > $LSUSB2
	diff -U 0 $LSUSB1 $LSUSB2 > $LSUSBDIFF
done

# Delete files that we no longer need

rm $LSUSB1
rm $LSUSB2

# Get the line containing the device ID from the diff file
# Then extract VID & PID

DEVICELINE=`sed -n '4{p;q;}' $LSUSBDIFF`
USBDEVICE=`echo $DEVICELINE | awk '{print $6}'`
VID=`echo $USBDEVICE | awk -F':' '{print $1}'`
PID=`echo $USBDEVICE | awk -F':' '{print $2}'`

# Further cleanup

rm $LSUSBDIFF

# We are good to go

echo .
echo "Detected USB device := ${VID}:${PID}"
echo .

# Copy files to the appropriate location & name

cp $KCM_SOURCE ${BASEPATH}/${KCM}/Vendor_${VID}_Product_${PID}.kcm

if [ "$?" != "0" ]
then
	echo "Failed to write KCM: ${BASEPATH}/${KCM}/Vendor_${VID}_Product_${PID}.kcm"
	exit 1
fi

echo "Key Character Map written := Vendor_${VID}_Product_${PID}.kcm"

cp $KL_SOURCE ${BASEPATH}/${KL}/Vendor_${VID}_Product_${PID}.kl

if [ "$?" != "0" ]
then
	echo "Failed to write KL: ${BASEPATH}/${KL}/Vendor_${VID}_Product_${PID}.kl"
	exit 1
fi

echo "Keyboard Layout written := Vendor_${VID}_Product_${PID}.kl"

echo .
echo "**********************************************************"
echo "**                                                      **"
echo "**  Done. You can now reconnect your keyboard.          **"
echo "**  Please check logcat for errors                      **"
echo "**  Test in an unicode enabled app, e.g. a web browser  **"
echo "**                                                      **"
echo "**********************************************************"
echo .
