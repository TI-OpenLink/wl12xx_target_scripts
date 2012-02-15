#!/system/bin/sh

INSMOD=/system/bin/insmod
RMMOD=/system/bin/rmmod
IFCONFIG=/system/bin/ifconfig
WPA_CLI=/system/bin/wpa_cli

WLAN_IF=wlan0
WLAN_IP=192.168.1.20
WLAN_NETMASK=255.255.255.0

SERVICE_SUPPLICANT=wpa_supplicant

SUPP_STAT=`getprop init.svc.$SERVICE_SUPPLICANT`
echo "wpa_supplicant state: $SUPP_STAT"
if [ ! "$SUPP_STAT" == "running" ] ; then echo "supplicant is not in running state, exiting..." ; exit 0 ; fi

echo "unload supplicant"
setprop ctl.stop $SERVICE_SUPPLICANT
#$WPA_CLI -i$WLAN_IF -p/data/misc/wifi/wlan0 terminate
sleep 1

echo "disable interface"
$IFCONFIG $WLAN_IF down
sleep 1

echo "unload driver"
$RMMOD wlcore_sdio

