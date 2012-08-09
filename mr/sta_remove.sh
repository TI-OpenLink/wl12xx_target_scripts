#!/system/bin/sh
# System Test ; Script version = 1.1

INSMOD=/system/bin/insmod
RMMOD=/system/bin/rmmod
IFCONFIG=/system/bin/ifconfig
WPA_CLI=/system/bin/wpa_cli
IW=/system/bin/iw

WLAN_IF=wlan0
P2P_WLAN_IF=p2p0

SERVICE_SUPPLICANT=p2p_supplicant

echo "unload supplicant"
setprop ctl.stop $SERVICE_SUPPLICANT
sleep 1

echo "disable interfaces"
$IFCONFIG $P2P_WLAN_IF down
$IFCONFIG $WLAN_IF down
sleep 1

echo "Removing interfaces"
$IW $P2P_WLAN_IF del
$IW $WLAN_IF del
sleep 1


