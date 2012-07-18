#!/system/bin/sh

INSMOD=/system/bin/insmod
IFCONFIG=/system/bin/ifconfig
HOSTAPD=/system/bin/hostapd
IW=/system/bin/iw
HOSTAPD_CONF=/data/misc/wifi/hostapd.conf
RMMOD=/system/bin/rmmod


WLAN_IF=wlan1
WLAN_IP=192.168.43.1
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
$INSMOD /system/lib/modules/wlcore_sdio.ko
sleep 1

echo "creating new interface"
$IW wlan0 del
$IW `ls /sys/class/ieee80211/` interface add wlan1 type managed

if [ ! -f $HOSTAPD_CONF ] ; then \
        cp /etc/wifi/hostapd.conf $HOSTAPD_CONF ; \
        fi
        chmod 777 $HOSTAPD_CONF

        echo "setting regulatory domain"
        $IW reg set `grep country_code= /data/misc/wifi/hostapd.conf | sed "s:country_code=::"`
        $IW reg get

#Check that AP is not configured to both 40MHz and BG bnad
BW40=`cat $HOSTAPD_CONF |grep 'HT40'`
HW_g=`cat $HOSTAPD_CONF |grep 'hw_mode=g'`

if [ "${BW40:0:2}" = "#h"  ]; then
  BW40=""
fi

if [ ! -n "$BW40" ] || [ ! -n "$HW_g" ]; then
  echo "loading hostapd"
  setprop ctl.start $SERVICE_HOSTAPD
  sleep 2
else echo "APUT is configured to both 40MHz channel BW and BG band. This combination is not supported. Exiting... "; echo "unload driver"; $RMMOD wlcore_sdio; exit 0;
fi
#End of AP capab check

echo "enable interface"
$IFCONFIG $WLAN_IF up $WLAN_IP netmask $WLAN_NETMASK
sleep 1
$IFCONFIG $WLAN_IF
sleep 2

echo "starting dhcp deamon"
udhcpd /data/misc/wifi/dhcpd.conf

