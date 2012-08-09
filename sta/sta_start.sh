#!/system/bin/sh

IW=/system/bin/iw
INSMOD=/system/bin/insmod
IFCONFIG=/system/bin/ifconfig
WPA_SUPPLICANT=/system/bin/wpa_supplicant


SUPPLICANT_CONF=/data/misc/wifi/wpa_supplicant.conf
P2P_SUPPLICANT_CONF=/data/misc/wifi/p2p_supplicant.conf

WLAN_IF=wlan0
WLAN_IP=192.168.1.20
WLAN_NETMASK=255.255.255.0

P2P_WLAN_IF=p2p0
P2P_WLAN_IP=0.0.0.0
P2P_WLAN_NETMASK=255.255.255.0

SERVICE_SUPPLICANT=p2p_supplicant
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

PHY=`ls /sys/class/ieee80211/`

echo "adding p2p0 interface"
$IW $PHY interface add $P2P_WLAN_IF type managed
sleep 1

echo "enable wlan0 interface"
$IFCONFIG $WLAN_IF up $WLAN_IP netmask $WLAN_NETMASK
sleep 1
$IFCONFIG $WLAN_IF

echo "enable p2p0 interface"
$IFCONFIG $P2P_WLAN_IF up
sleep 1
$IFCONFIG $P2P_WLAN_IF

if [ ! -f $SUPPLICANT_CONF ] ; then \
	cp /etc/wifi/wpa_supplicant.conf $SUPPLICANT_CONF ; \
fi
chmod 777 $SUPPLICANT_CONF
echo "reseting p2p_supplicant conf"
cp /etc/wifi/wpa_supplicant.conf $P2P_SUPPLICANT_CONF
sed -rie "s/ctrl_interface=wlan0/ctrl_interface=\/data\/misc\/wifi\/sockets/" $P2P_SUPPLICANT_CONF
chmod 777 $P2P_SUPPLICANT_CONF

echo "loading supplicant"
setprop ctl.start "${SERVICE_SUPPLICANT}"
sleep 1

alias p2p_cli="wpa_cli -i p2p0 -p /data/misc/wifi/sockets/"

