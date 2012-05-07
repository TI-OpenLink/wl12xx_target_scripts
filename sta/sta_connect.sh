#!/system/bin/sh

wpa_cli add_network
wpa_cli set_network 0 auth_alg OPEN
wpa_cli set_network 0 key_mgmt NONE
wpa_cli set_network 0 mode 0
wpa_cli set_network 0 ssid '"YOUR_SSID"'
sleep 1
wpa_cli select_network 0

