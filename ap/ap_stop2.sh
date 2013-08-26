#!/bin/sh
echo "Terminating 2nd AP"
#ps | grep h[o]stapd2
output=`ps |grep h[o]stapd2`
set -- $output
kill $1



#ps | grep u[d]hcpd2
output=`ps | grep u[d]hcpd2`
set -- $output
kill $1 
