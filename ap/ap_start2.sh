#!/bin/sh

echo 1 > /proc/sys/net/ipv4/ip_forward

if [ ! -d /sys/class/net/wlan2 ]
then
  echo "adding wlan2 interface"
  iw phy `ls /sys/class/ieee80211/` interface add wlan2 type managed
fi

hostapd /usr/share/wl18xx/hostapd2.conf -P /var/run/hostapd2.pid &
ifconfig wlan2 192.168.53.1
udhcpd /usr/share/wl18xx/udhcpd2.conf
