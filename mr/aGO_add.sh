#!/system/bin/sh

if [ "$1" == "" -o "$2" == "" ] ; then 
	echo "Please insert parameters <IP> <NEW_aGO_CHANNEL> [MAC]" 
	echo "MAC is optional" 
	echo "ie: aGO_add.sh 10.2.47.6 6 08:00:28:13:33:38" 
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
WLAN_NETMASK=255.255.255.0
MAC=$3
CHANNEL=$2
PHY=`ls /sys/class/ieee80211/`
DEV_NAME=p2p_blaze
GO_INTENT=7
CHANNEL_FREQ=0

if [ "$CHANNEL" -ge 149 ] ; then 
	let "CHANNEL_FREQ = (($CHANNEL - 149) * 5) + 5745"
elif [ "$CHANNEL" -ge 36 ] ; then 
	let "CHANNEL_FREQ = (($CHANNEL - 36) * 5) + 5180"
elif [ "$CHANNEL" -ge 1 ] ; then 
	let "CHANNEL_FREQ = (($CHANNEL - 1) * 5) + 2412"
else
	echo "CH in not in range" 
fi

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

echo "Configurating p2p parameters"
$WPA_CLI -i $WLAN_IF_aGO -p $SOCKET_PATH set device_name $DEV_NAME
$WPA_CLI -i $WLAN_IF_aGO -p $SOCKET_PATH set p2p_go_intent $GO_INTENT
sleep 1

echo "Starting aGO in ch : $CHANNEL_FREQ"
$WPA_CLI -i $WLAN_IF_aGO -p $SOCKET_PATH p2p_group_add freq=$CHANNEL_FREQ
sleep 1



