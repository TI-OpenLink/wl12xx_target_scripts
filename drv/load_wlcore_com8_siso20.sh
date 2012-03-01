#!/system/bin/sh

insmod /system/lib/modules/compat.ko
insmod /system/lib/modules/cfg80211.ko
insmod /system/lib/modules/mac80211.ko
insmod /system/lib/modules/wlcore.ko
insmod /system/lib/modules/wl12xx.ko
insmod /system/lib/modules/wl18xx.ko board_type=com8 ht_mode=siso20 n_antennas_2=1 n_antennas_5=1 dc2dc=0 low_band_component=1 low_band_component_type=6 high_band_component=1 high_band_component_type=5

