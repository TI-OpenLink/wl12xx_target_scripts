#!/system/bin/sh

HOSTAPD_CLI=/system/bin/hostapd_cli
WLAN_IF=wlan0

$HOSTAPD_CLI -i$WLAN_IF $@

