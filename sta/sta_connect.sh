#!/bin/sh

wpa_cli -i wlan0 add_network
wpa_cli -i wlan0 set_network 0 auth_alg OPEN
wpa_cli -i wlan0 set_network 0 key_mgmt NONE
wpa_cli -i wlan0 set_network 0 mode 0
wpa_cli -i wlan0 set_network 0 ssid '"YOUR_SSID"'
sleep 1
wpa_cli -i wlan0 select_network 0

#udhcpc -i wlan0

