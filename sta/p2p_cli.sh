#!/system/bin/sh

WPA_CLI=/system/bin/wpa_cli
WLAN_IF=/data/misc/wifi/sockets/p2p0

$WPA_CLI -i$WLAN_IF $@
