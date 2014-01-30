#!/bin/sh

########## variables ##########

WLAN=wlan1
HOSTAPD_GLOBAL=/var/run/hostapd_global
HOSTAPD_CONF=/usr/share/wl18xx/hostapd.conf
HOSTAPD_BIN_DIR=/usr/local/bin
IP_ADDR=192.168.43.1
DHCP_CONF=u[d]hcpd.conf

########## body ##########

### check for configuration file
if [ ! -f $HOSTAPD_CONF ] && [ $WLAN == "wlan2" ]; then
 echo "error - no default hostapd.conf for $WLAN"
 exit 1
else
 chmod 777 $HOSTAPD_CONF
fi

if [ ! -f $HOSTAPD_CONF ] && [ $WLAN == "wlan1" ]; then
 if [ ! -f /etc/hostapd.conf ]
 then
  echo "error - no default hostapd.conf for $WLAN"
  exit 1
 fi
 cp /etc/hostapd.conf $HOSTAPD_CONF
 chmod 777 $HOSTAPD_CONF
fi

### configure ip forewarding
echo 1 > /proc/sys/net/ipv4/ip_forward

### add WLAN interface, if not present
if [ ! -d /sys/class/net/$WLAN ]
then
  echo "adding $WLAN interface"
  iw phy `ls /sys/class/ieee80211/` interface add $WLAN type managed
fi

### start a hostapd global control interface, if not present
if [ ! -r $HOSTAPD_GLOBAL ]
then
 $HOSTAPD_BIN_DIR/hostapd -g $HOSTAPD_GLOBAL &
 sleep 1 
fi

### add ap interface
$HOSTAPD_BIN_DIR/hostapd_cli -g $HOSTAPD_GLOBAL raw ADD $WLAN config=$HOSTAPD_CONF enable=1

### configure ip
ifconfig $WLAN $IP_ADDR netmask 255.255.255.0 up

### start udhcpd server, if not started
output=`ps | grep /usr/share/wl18xx\$DHCP_CONF`
set -- $output
echo $output
if [ -z "$output" ]; then
 udhcpd $DHCP_CONF
fi

### configure nat
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

