#!/system/bin/sh
# System Test ; Script version = 1.1

INSMOD=/system/bin/insmod
RMMOD=/system/bin/rmmod
IFCONFIG=/system/bin/ifconfig
HOSTAPD_CLI=/system/bin/wpa_cli
IW=/system/bin/iw

WLAN_IF=wlan1
WLAN_IF_MON=mon.$WLAN_IF

SERVICE_HOSTAPD=hostapd_bin

echo "kill udhcpd"
killall udhcpd

echo "unload hostapd"
setprop ctl.stop $SERVICE_HOSTAPD
sleep 1

echo "disable interface"
$IFCONFIG $WLAN_IF down
$IFCONFIG $WLAN_IF_MON down
sleep 1

echo "Removing interface"
$IW $WLAN_IF del
sleep 1

