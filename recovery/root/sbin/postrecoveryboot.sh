#!/sbin/sh
#
# Copyright (C) 2012, 2013 fredvj
#
# Clear misc partition - Allow reboot to ROM
#
/sbin/busybox dd bs=512 count=1 if=/dev/zero of=/dev/block/nandf

