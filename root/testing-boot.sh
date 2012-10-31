#!/system/bin/sh

/system/bin/ifconfig eth0 20.1.1.20 netmask 255.255.255.0 up
/system/xbin/busybox/telnetd -l sh

mkdir -p /data/misc/wifi/fwlogs
chmod 777 /data/misc/wifi/fwlogs

/system/bin/wl_logproxy 0 /sys/devices/platform/omap/omap_hsmmc.4/mmc_host/mmc2/mmc2:0001/mmc2:0001:2/wl12xx/fwlog /data/misc/wifi/fwlogs/ 10000000 &
