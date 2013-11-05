#!/bin/sh
echo "Terminating 2nd AP "

ps | grep h[o]stapd2
output=`ps |grep h[o]stapd2`
set -- $output
kill $1


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


