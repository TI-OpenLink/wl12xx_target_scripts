#!/system/bin/sh

HOSTAPD_CLI=/system/bin/hostapd_cli
WLAN_IF=wlan1

$HOSTAPD_CLI -i$WLAN_IF $@

