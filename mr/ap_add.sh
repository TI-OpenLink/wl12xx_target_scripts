#!/system/bin/sh

INSMOD=/system/bin/insmod
IFCONFIG=/system/bin/ifconfig
HOSTAPD=/system/bin/hostapd
IW=/system/bin/iw
HOSTAPD_CONF=/data/misc/wifi/hostapd.conf

if [ "$1"=="" -a "$2"=="" ]; then
echo "please give MAC and desired MAC address - exiting ..." ; exit 1; fi

WLAN1_MAC=$1
STA_CHANNEL=$2
WLAN_IF=wlan1
WLAN_IP=192.168.43.1
WLAN_NETMASK=255.255.255.0

SERVICE_SUPPLICANT=wpa_supplicant
SERVICE_HOSTAPD=hostapd_bin

SUPP_STAT=`getprop init.svc.$SERVICE_SUPPLICANT`
echo "wpa_supplicant state: $SUPP_STAT"

HOSTAPD_STAT=`getprop init.svc.$SERVICE_HOSTAPD`
echo "hostapd state: $HOSTAPD_STAT"
if [ "$HOSTAPD_STAT" == "running" ] ; then echo "hostapd is in running state, exiting..." ; exit 0 ; fi


sleep 1
iw wlan0 set power_save off

echo "creating new interface"
$IW `ls /sys/class/ieee80211/` interface add wlan1 type managed
ifconfig wlan1 hw ether $WLAN1_MAC

if [ ! -f $HOSTAPD_CONF ] ; then \
	cp /etc/wifi/hostapd.conf $HOSTAPD_CONF ; \
	chmod 777 $HOSTAPD_CONF ; \
fi

echo "loading hostapd"
echo "setting the correct channel"
sed s/channel=[0-9]*/channel=$STA_CHANNEL/ $HOSTAPD_CONF > /data/misc/wifi/tmp.conf
mv -f /data/misc/wifi/tmp.conf $HOSTAPD_CONF

sleep 1
setprop ctl.start $SERVICE_HOSTAPD
sleep 2

echo "enable interface"
$IFCONFIG $WLAN_IF up $WLAN_IP netmask $WLAN_NETMASK
sleep 1
$IFCONFIG $WLAN_IF
sleep 2

echo "starting dhcp deamon"
udhcpd -f dhcpd.conf &









