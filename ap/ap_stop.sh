#!/bin/sh
ap_pid=$(<"/var/run/hostapd.pid")

echo "Terminating 1st AP - pid " $ap_pid

if [ -n "$ap_pid" ]; then
kill $ap_pid
fi

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
