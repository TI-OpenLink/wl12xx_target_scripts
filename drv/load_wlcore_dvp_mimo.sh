#!/system/bin/sh

insmod /system/lib/modules/compat.ko
insmod /system/lib/modules/cfg80211.ko
insmod /system/lib/modules/mac80211.ko
insmod /system/lib/modules/wlcore.ko
insmod /system/lib/modules/wl12xx.ko
insmod /system/lib/modules/wl18xx.ko low_band_component=2 low_band_component_type=4 high_band_component_type=9 board_type=dvp ht_mode=mimo n_antennas_2=2 n_antennas_5=2 dc2dc=0

