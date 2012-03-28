#!/system/bin/sh
# System Test ; Script version = 1.1

if [ "$1" == "" -o "$2" == "" ] ; then 
	echo "Please insert parameters <IP> <NEW_APUT_CHANNEL> [MAC]" 
	echo "MAC is optional" 
	echo "ie: ap_add.sh 10.2.47.6 11 08:00:28:13:33:38" 
	exit 0 
fi

INSMOD=/system/bin/insmod
IFCONFIG=/system/xbin/busybox/ifconfig
HOSTAPD=/system/bin/hostapd
IW=/system/bin/iw
HOSTAPD_CONF=/data/misc/wifi/hostapd.conf

WLAN_IF_SUT=wlan0
WLAN_IF_APUT=wlan1
WLAN_IP=$1
WLAN_NETMASK=255.255.255.0
MAC=$3
CHANNEL=$2
PHY=`ls /sys/class/ieee80211/`

SERVICE_SUPPLICANT=wpa_supplicant
SERVICE_HOSTAPD=hostapd_bin

echo "setting regulatory domain"
$IW reg set `grep country_code= $HOSTAPD_CONF | sed "s:country_code=::"`
$IW reg get

echo "creating new interface"
$IW $PHY interface add $WLAN_IF_APUT type managed
sleep 1

if [ "$MAC" != "" ] ; then
	echo "setting new mac" 
	$IFCONFIG $WLAN_IF_APUT hw ether $MAC 
fi

if [ ! -f $HOSTAPD_CONF ] ; then 
	cp /etc/wifi/hostapd.conf $HOSTAPD_CONF 
fi
chmod 777 $HOSTAPD_CONF 

########################### Hostapd file modify ###########################
if [ "$CHANNEL" -ge 36 ] ; then
	sed -i 's/^hw_mode=.*/hw_mode=a/' $HOSTAPD_CONF
else
	sed -i 's/^hw_mode=.*/hw_mode=g/' $HOSTAPD_CONF
fi
sed -i 's/^channel=.*/channel='$CHANNEL'/' $HOSTAPD_CONF
############################################################################

echo "loading hostapd"
setprop ctl.start $SERVICE_HOSTAPD
sleep 2

echo "enable interface"
$IFCONFIG $WLAN_IF_APUT $WLAN_IP netmask $WLAN_NETMASK
sleep 1

echo "starting dhcp deamon"
udhcpd -f dhcpd.conf &
