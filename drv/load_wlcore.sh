#!/bin/sh

if ! mount | grep debugfs > /dev/null; then
        echo "Mount debugfs"
        mount -t debugfs none /sys/kernel/debug
fi

modprobe wl18xx
modprobe wlcore_sdio

