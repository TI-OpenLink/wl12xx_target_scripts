#!/system/bin/sh

INSMOD=/system/bin/insmod
RMMOD=/system/bin/rmmod
IFCONFIG=/system/bin/ifconfig
HOSTAPD_CLI=/system/bin/wpa_cli

WLAN_IF=wlan1

SERVICE_HOSTAPD=hostapd_bin

HOSTAPD_STAT=`getprop init.svc.$SERVICE_HOSTAPD`
echo "hostapd state: $HOSTAPD_STAT"
if [ ! "$HOSTAPD_STAT" == "running" ] ; then echo "hostapd is not in running state, exiting..." ; exit 0 ; fi

echo "kill udhcpd"
killall udhcpd

echo "unload hostapd"
setprop ctl.stop $SERVICE_HOSTAPD
#$WPA_CLI -i$WLAN_IF -p/data/misc/wifi/wlan0 terminate
sleep 1

echo "disable interface"
$IFCONFIG $WLAN_IF down
sleep 1

echo "unload driver"
$RMMOD wl12xx_sdio
sleep 1
$RMMOD wl12xx
$RMMOD mac80211
$RMMOD cfg80211
$RMMOD compat
sleep 1
$INSMOD /system/lib/modules/compat.ko
$INSMOD /system/lib/modules/cfg80211.ko
$INSMOD /system/lib/modules/mac80211.ko
$INSMOD /system/lib/modules/wl12xx.ko debug_level=0x63c00

