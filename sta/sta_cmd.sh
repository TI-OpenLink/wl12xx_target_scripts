#!/system/bin/sh

WPA_CLI=/system/bin/wpa_cli
WLAN_IF=wlan0

#$WPA_CLI -i$WLAN_IF -p/data/misc/wifi/wlan0 $@
$WPA_CLI $@

