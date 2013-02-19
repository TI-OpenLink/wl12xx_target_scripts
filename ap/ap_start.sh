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

ifconfig wlan0 192.168.0.1
hostapd -B /usr/share/wl18xx/hostapd.conf -P /var/run/hostapd.pid
udhcpd /etc/udhcpd.conf
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

