#!/bin/sh
ap2_pid=$(<"/var/run/hostapd2.pid")
echo "Terminating 2nd AP - pid " $ap2_pid

kill $ap2_pid


#ps | grep u[d]hcpd2
output=`ps | grep u[d]hcpd2`
set -- $output
kill $1
