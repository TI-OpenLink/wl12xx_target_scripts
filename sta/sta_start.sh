#!/bin/sh

if [ ! -f /usr/share/wl18xx/wpa_supplicant.conf ] 
then
 if [ ! -f /etc/wpa_supplicant.conf ]
 then
  echo "error - no default wpa_supplicant.conf"
  exit 1
 fi
 cp /etc/wpa_supplicant.conf /usr/share/wl18xx/wpa_supplicant.conf
fi

if [ ! -f /usr/share/wl18xx/p2p_supplicant.conf ] 
then
 if [ ! -f /etc/p2p_supplicant.conf ]
 then
  echo "error - no default p2p_supplicant.conf"
  exit 1
 fi
 cp /etc/p2p_supplicant.conf /usr/share/wl18xx/p2p_supplicant.conf
fi

if [ ! -d /sys/class/net/p2p0 ]
then
  echo "adding p2p0 interface"
  iw phy `ls /sys/class/ieee80211/` interface add p2p0 type managed
fi

wpa_supplicant -B -e/usr/share/wl18xx/entropy.bin \
	-ip2p0 -Dnl80211 -c/usr/share/wl18xx/p2p_supplicant.conf -N \
	-iwlan0 -Dnl80211 -c/usr/share/wl18xx/wpa_supplicant.conf \

