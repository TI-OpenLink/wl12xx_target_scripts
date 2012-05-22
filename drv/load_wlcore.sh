#!/system/bin/sh

insmod /system/lib/modules/compat.ko
insmod /system/lib/modules/cfg80211.ko
insmod /system/lib/modules/mac80211.ko
#insmod /system/lib/modules/wlcore.ko irq=sdio
insmod /system/lib/modules/wlcore.ko
insmod /system/lib/modules/wl12xx.ko

