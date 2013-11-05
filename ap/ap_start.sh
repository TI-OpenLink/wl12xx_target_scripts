#!/bin/sh

if [ ! -f /usr/share/wl18xx/hostapd.conf ] 
then
 if [ ! -f /etc/hostapd.conf ]
 then
  echo "error - no default hostapd.conf"
  exit 1
 fi
 cp /etc/hostapd.conf /usr/share/wl18xx/hostapd.conf
 chmod 777 /usr/share/wl18xx/hostapd.conf
fi

echo 1 > /proc/sys/net/ipv4/ip_forward

if [ ! -d /sys/class/net/wlan1 ]
then
  echo "adding wlan1 interface"
  iw phy `ls /sys/class/ieee80211/` interface add wlan1 type managed
fi

hostapd /usr/share/wl18xx/hostapd.conf -P /var/run/hostapd.pid &
ifconfig wlan1 192.168.43.1
udhcpd /usr/share/wl18xx/udhcpd.conf
#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

