#!/system/bin/sh

INSMOD=/system/bin/insmod
RMMOD=/system/bin/rmmod
IFCONFIG=/system/bin/ifconfig
WPA_CLI=/system/bin/wpa_cli
CHMOD=/system/bin/chmod

WLAN_IF=wlan0
WLAN_IP=192.168.1.20
WLAN_NETMASK=255.255.255.0

P2P_WLAN_IF=p2p0
P2P_WLAN_IP=0.0.0.0
P2P_WLAN_NETMASK=255.255.255.0

SERVICE_SUPPLICANT=p2p_supplicant

STA_SUPP_CONF=/data/misc/wifi/wpa_supplicant.conf
P2P_SUPP_CONF=/data/misc/wifi/p2p_supplicant.conf

SUPP_STAT=`getprop init.svc.$SERVICE_SUPPLICANT`
echo "wpa_supplicant state: $SUPP_STAT"
if [ ! "$SUPP_STAT" == "running" ] ; then echo "supplicant is not in running state, exiting..." ; exit 0 ; fi

echo "unload supplicant"
setprop ctl.stop $SERVICE_SUPPLICANT
#$WPA_CLI -i$WLAN_IF -p/data/misc/wifi/wlan0 terminate
sleep 1

echo "disable interfaces"
$IFCONFIG $WLAN_IF down
$IFCONFIG $P2P_WLAN_IF down
sleep 1

echo "unload driver"
$RMMOD wl12xx_sdio

$CHMOD 777 $STA_SUPP_CONF
$CHMOD 777 $P2P_SUPP_CONF
