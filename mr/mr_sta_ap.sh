echo 8 > /proc/sys/kernel/printk
mount -t debugfs debugfs /debug
insmod /lib/modules/`uname -r`/kernel/net/wireless/cfg80211.ko
insmod /lib/modules/`uname -r`/kernel/net/mac80211/mac80211.ko
insmod /lib/modules/`uname -r`/kernel/lib/crc7.ko
insmod /lib/modules/`uname -r`/kernel/drivers/base/firmware_class.ko
insmod /lib/modules/`uname -r`/kernel/drivers/net/wireless/wl12xx/wl12xx.ko fwlog=dbgpins
insmod /lib/modules/`uname -r`/kernel/drivers/net/wireless/wl12xx/wl12xx_sdio.ko
echo 1 > /debug/ieee80211/phy0/uapsd_max_sp_len
sleep 1
ifconfig wlan0 hw ether 08:00:28:XX:XX:XX
sleep 1
ifconfig wlan0 up
sleep 1
iw wlan0 set power_save off
sleep 1
iw phy0 interface add wlan1 type managed
ifconfig wlan1 hw ether 08:00:28:XX:XX:XX
hostapd wlan1.conf&




# iw dev wlan0 link 2>/dev/null | grep freq | sed 's/.*freq: //'