#!/bin/bash
#
# Copyright (C) 2012, fredvj
#

mkimage -A arm -O u-boot -T script -C none -n "boot" -d boot.cmd boot.scr
