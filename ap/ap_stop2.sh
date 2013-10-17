#!/bin/sh
ap2_pid=$(<"/var/run/hostapd2.pid")
echo "Terminating 2nd AP - pid " $ap2_pid

if [ -n "$ap2_pid" ]; then
  kill $ap2_pid
fi

#ps | grep u[d]hcpd2
output=`ps | grep u[d]hcpd2`
set -- $output
if [ -n "$output" ]; then
 kill $1
fi

if [ -d /sys/class/net/wlan2 ]
then
 iw wlan2 del
fi


