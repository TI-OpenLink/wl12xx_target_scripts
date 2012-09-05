#!/system/bin/sh

insmod /system/lib/modules/compat.ko
insmod /system/lib/modules/cfg80211.ko
insmod /system/lib/modules/mac80211.ko disable_scan_while_active=0
insmod /system/lib/modules/wlcore.ko
insmod /system/lib/modules/wl12xx.ko
insmod /system/lib/modules/wl18xx.ko board_type=hdk ht_mode=mimo n_antennas_2=2 n_antennas_5=2 dc2dc=0

