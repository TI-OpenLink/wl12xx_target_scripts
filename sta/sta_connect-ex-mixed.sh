wpa_cli disconnect
for i in `wpa_cli list_networks | grep ^[0-9] | cut -f1`; do wpa_cli remove_network $i; done
wpa_cli add_network
wpa_cli set_network 0 auth_alg OPEN
wpa_cli set_network 0 key_mgmt WPA-PSK
wpa_cli set_network 0 psk '"0123456789"'
wpa_cli set_network 0 pairwise CCMP TKIP
wpa_cli set_network 0 proto RSN
wpa_cli set_network 0 group TKIP
wpa_cli set_network 0 mode 0
wpa_cli set_network 0 ssid '"LaShnup"'
wpa_cli select_network 0
wpa_cli enable_network 0
wpa_cli reassociate
wpa_cli status