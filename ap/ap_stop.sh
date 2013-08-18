#!/bin/sh                             
ps | grep -v hostapd2 | grep h[o]stapd
output=`ps |grep h[o]stapd`
set -- $output
echo $1
kill $1