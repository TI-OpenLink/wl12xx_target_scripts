killall hostapd
killall udhcpd

if [ -d /sys/class/net/wlan1 ]
then
 iw wlan1 del
fi

if [ -d /sys/class/net/wlan2 ]
then
 iw wlan2 del
fi
