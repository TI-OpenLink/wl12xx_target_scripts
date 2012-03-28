#!/system/bin/sh

/system/bin/ifconfig eth0 20.1.1.20 netmask 255.255.255.0 up
/system/xbin/busybox/telnetd -l sh
