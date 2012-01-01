#!/system/bin/sh

INSMOD=/system/bin/insmod
IFCONFIG=/system/bin/ifconfig
WPA_SUPPLICANT=/system/bin/wpa_supplicant

SUPPLICANT_CONF=/data/misc/wifi/wpa_supplicant.conf

WLAN_IF=wlan0
WLAN_IP=192.168.1.20
WLAN_NETMASK=255.255.255.0

SERVICE_SUPPLICANT=wpa_supplicant
SERVICE_HOSTAPD=hostapd_bin

SUPP_STAT=`getprop init.svc.$SERVICE_SUPPLICANT`
echo "wpa_supplicant state: $SUPP_STAT"
if [ "$SUPP_STAT" == "running" ] ; then echo "supplicant is in running state, exiting..." ; exit 0 ; fi

HOSTAPD_STAT=`getprop init.svc.$SERVICE_HOSTAPD`
echo "hostapd state: $HOSTAPD_STAT"
if [ "$HOSTAPD_STAT" == "running" ] ; then echo "hostapd is in running state, exiting..." ; exit 0 ; fi

echo "loading driver"
$INSMOD /system/lib/modules/wl12xx_sdio.ko
sleep 1

echo "enable interface"
$IFCONFIG $WLAN_IF up $WLAN_IP netmask $WLAN_NETMASK
sleep 1
$IFCONFIG $WLAN_IF

if [ ! -f $SUPPLICANT_CONF ] ; then \
	cp /etc/wifi/wpa_supplicant.conf $SUPPLICANT_CONF ; \
fi
chmod 777 $SUPPLICANT_CONF

echo "loading supplicant"
setprop ctl.start "$SERVICE_SUPPLICANT:-i$WLAN_IF -c$SUPPLICANT_CONF"
#$WPA_SUPPLICANT -i$WLAN_IF -c$SUPPLICANT_CONF &
sleep 1

