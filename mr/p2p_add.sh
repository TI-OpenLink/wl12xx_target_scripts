#!/system/bin/sh

if [ "$1" == "" -o "$2" == "" ] ; then 
	echo "Please insert parameters <IP> [MAC]" 
	echo "MAC is optional" 
	echo "ie: p2p_add.sh 10.2.47.6 08:00:28:13:33:38" 
	exit 0 
fi

INSMOD=/system/bin/insmod
IFCONFIG=/system/xbin/busybox/ifconfig
HOSTAPD=/system/bin/hostapd
IW=/system/bin/iw
WPA_CLI=/system/bin/wpa_cli
HOSTAPD_CONF=/data/misc/wifi/hostapd.conf
P2P_CONF=/data/misc/wifi/p2p_supplicant.conf
SOCKET_PATH=/data/misc/wifi

SERVICE_SUPPLICANT=wpa_supplicant
SERVICE_HOSTAPD=hostapd_bin

WLAN_IF_SUT=wlan0
WLAN_IF_aGO=p2p_wlan0
WLAN_IP=$1
WLAN_NETMASK=255.255.255.02
MAC=$2
PHY=`ls /sys/class/ieee80211/`


echo "creating new interface"
$IW $PHY interface add $WLAN_IF_aGO type managed
sleep 1

if [ "$MAC" != "" ] ; then
	echo "setting new mac" 
	$IFCONFIG $WLAN_IF_aGO hw ether $MAC 
fi

echo "enable interface"
$IFCONFIG $WLAN_IF_aGO up $WLAN_IP netmask $WLAN_NETMASK
sleep 1

if [ ! -f $P2P_CONF ] ; then 
	cp /etc/wifi/p2p_supplicant.conf $P2P_CONF 
fi
chmod 777 $P2P_CONF 

echo "loading p2p supplicant"
$SERVICE_SUPPLICANT -Dnl80211 -i $WLAN_IF_aGO -c $P2P_CONF -d &
sleep 1


