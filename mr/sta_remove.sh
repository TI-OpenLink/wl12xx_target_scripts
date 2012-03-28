#!/system/bin/sh
# System Test ; Script version = 1.1

INSMOD=/system/bin/insmod
RMMOD=/system/bin/rmmod
IFCONFIG=/system/bin/ifconfig
WPA_CLI=/system/bin/wpa_cli
IW=/system/bin/iw

WLAN_IF=wlan0

SERVICE_SUPPLICANT=wpa_supplicant

echo "unload supplicant"
setprop ctl.stop $SERVICE_SUPPLICANT
sleep 1

echo "disable interface"
$IFCONFIG $WLAN_IF down
sleep 1

echo "Removing interface"
$IW $WLAN_IF del
sleep 1


