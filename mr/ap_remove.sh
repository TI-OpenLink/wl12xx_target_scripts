#!/bin/sh
# System Test ; Script version = 1.1

INSMOD=/sbin/insmod
RMMOD=/sbin/rmmod
IFCONFIG=/sbin/ifconfig
HOSTAPD_CLI=/usr/local/bin/hostapd_cli
IW=/usr/sbin/iw
SERVICE_HOSTAPD=hostapd_bin


WLAN_IF=wlan1
WLAN_IF_MON=mon.$WLAN_IF


echo "unload hostapd"
killall hostapd
sleep 1

echo "kill udhcpd"
killall -9 udhcpd

echo "disable interface"
$IFCONFIG $WLAN_IF down
$IFCONFIG $WLAN_IF_MON down
sleep 1

echo "Removing interface"
$IW $WLAN_IF del
sleep 1

