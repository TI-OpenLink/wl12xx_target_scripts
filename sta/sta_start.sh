#!/bin/sh

if [ ! -f /home/root/wpa_supplicant.conf ] 
then
 if [ ! -f /etc/wpa_supplicant.conf ]
 then
  echo "error - no default wpa_supplicant.conf"
  exit 1
 fi
 cp /etc/wpa_supplicant.conf /home/root/wpa_supplicant.conf
fi

if [ ! -f /home/root/p2p_supplicant.conf ] 
then
 cp /home/root/wpa_supplicant.conf /home/root/p2p_supplicant.conf
 sed -rie "s/ctrl_interface=\/var\/run\/wpa_supplicant/ctrl_interface=p2p0/" /home/root/p2p_supplicant.conf
fi

iw phy `ls /sys/class/ieee80211/` interface add p2p0 type station

wpa_supplicant -B -e/home/root/entropy.bin \
	-iwlan0 -Dnl80211 -c/home/root/wpa_supplicant.conf -N \
	-ip2p0 -Dnl80211 -c/home/root/p2p_supplicant.conf

