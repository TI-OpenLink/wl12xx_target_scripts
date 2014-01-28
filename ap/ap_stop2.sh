#!/bin/sh

########## variables ##########

WLAN=wlan2
HOSTAPD_GLOBAL=/var/run/hostapd_global
DHCP_CONF=ud[h]cpd2.conf

########## body ##########

echo "Terminating #WLAN"
hostapd_cli -g $HOSTAPD_GLOBAL raw REMOVE $WLAN

output=`ps | grep $DHCP_CONF`
set -- $output
if [ -n "$output" ]; then
 kill $1
fi

if [ -d /sys/class/net/$WLAN ]
then
 iw $WLAN del
fi

