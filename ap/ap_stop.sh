#!/bin/sh
ap_pid=$(<"/var/run/hostapd.pid")

echo "Terminating 1st AP - pid " $ap_pid

kill $ap_pid

#ps | grep -v udhcpd2 | grep u[d]hcpd
output=`ps | grep -v udhcpd2 | grep u[d]hcpd`
set -- $output
kill $1
