#!/bin/sh

echo "Terminating 1st AP "

#ps | grep -v hostapd2 | grep h[o]stapd
output=`ps | grep -v hostapd2 | grep h[o]stapd`
set -- $output
kill $1

#ps | grep -v udhcpd2 | grep u[d]hcpd
output=`ps | grep -v udhcpd2 | grep u[d]hcpd`
set -- $output

if [ -n "$output" ]; then
 kill $1
fi

if [ -d /sys/class/net/wlan1 ]
then
 iw wlan1 del
fi
