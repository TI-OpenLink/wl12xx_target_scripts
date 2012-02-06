#!/system/bin/sh
# System Test ; Script version = 1.1

if [ "$1" == "" ] ; then 
	echo "Please insert parameters <IP> <NEW_APUT_CHANNEL> [MAC]" 
	echo "MAC is optional, if don't want to change APUT CH then enter second parameter: 0" 
	echo "ie: sta_add.sh 10.2.47.6 11 08:00:28:13:33:38" 
	exit 0 
fi

IW=/system/bin/iw
INSMOD=/system/bin/insmod
IFCONFIG=/system/xbin/busybox/ifconfig
WPA_SUPPLICANT=/system/bin/wpa_supplicant

SUPPLICANT_CONF=/data/misc/wifi/wpa_supplicant.conf
HOSTAPD_CONF=/data/misc/wifi/hostapd.conf

AP_START=/data/misc/wifi/ap_start.sh
AP_STOP=/data/misc/wifi/ap_stop.sh

WLAN_IF_SUT=wlan0
WLAN_IF_APUT=wlan1
WLAN_IP=$1
WLAN_NETMASK=255.255.255.0
MAC=$3
CHANNEL=$2
PHY=`ls /sys/class/ieee80211/`
CURRENT_AP_CHANNEL=`grep channel= $HOSTAPD_CONF | sed "s:channel=::"`

SERVICE_SUPPLICANT=wpa_supplicant
SERVICE_HOSTAPD=hostapd_bin

echo "adding interface"
$IW $PHY interface add $WLAN_IF_SUT type managed
sleep 1

if [ "$MAC" != "" ] ; then
	echo "setting new mac" 
	$IFCONFIG $WLAN_IF_SUT hw ether $MAC 
fi

echo "enable interface"
$IFCONFIG $WLAN_IF_SUT up $WLAN_IP netmask $WLAN_NETMASK
sleep 1

if [ ! -f $SUPPLICANT_CONF ] ; then 
	cp /etc/wifi/wpa_supplicant.conf $SUPPLICANT_CONF 
fi
chmod 777 $SUPPLICANT_CONF 

echo "loading supplicant"
setprop ctl.start "$SERVICE_SUPPLICANT:-i$WLAN_IF_SUT -c$SUPPLICANT_CONF"
sleep 1

if [ "$CHANNEL" != "$CURRENT_AP_CHANNEL" ] && [ "$CHANNEL" != "0" ] ; then
	#-------------------------- CHannel Change --------------------
	if [ "$CHANNEL" -ge 36 ] ; then
		sed -i 's/^hw_mode=.*/hw_mode=a/' $HOSTAPD_CONF
	else
		sed -i 's/^hw_mode=.*/hw_mode=g/' $HOSTAPD_CONF
	fi
	sed -i 's/^channel=.*/channel='$CHANNEL'/' $HOSTAPD_CONF

	#---------------------------- STOP_APUT -----------------------
	echo "kill udhcpd" 
	killall udhcpd 

	echo "unload hostapd" 
	setprop ctl.stop $SERVICE_HOSTAPD 
	sleep 1 

	echo "disable interface" 
	$IFCONFIG $WLAN_IF_APUT down 
	#---------------------------- STOP_APUT -----------------------

	sleep 3
	#---------------------------- START_APUT -----------------------
	echo "loading hostapd" 
	setprop ctl.start $SERVICE_HOSTAPD 
	sleep 2 

	echo "enable interface" 
	$IFCONFIG $WLAN_IF_APUT up  

	echo "starting dhcp deamon" 
	udhcpd -f dhcpd.conf & 
	#---------------------------- START_APUT -----------------------
fi












