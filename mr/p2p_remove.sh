#!/system/bin/sh
# System Test ; Script version = 1.1

INSMOD=/system/bin/insmod
RMMOD=/system/bin/rmmod
IFCONFIG=/system/bin/ifconfig
WPA_CLI=/system/bin/wpa_cli
IW=/system/bin/iw

WLAN_IF=p2p_wlan0
WLAN_IF_MON=mon.$WLAN_IF
WLAN_PID=`ps | grep [p2p_]wlan0 | cut -f3 -d' '`

SERVICE_SUPPLICANT=wpa_supplicant

echo "unload supplicant"
kill $WLAN_PID
sleep 1

echo "disable interface"
$IFCONFIG $WLAN_IF down
$IFCONFIG $WLAN_IF_MON down
sleep 1

echo "Removing interface"
$IW $WLAN_IF del
sleep 1


