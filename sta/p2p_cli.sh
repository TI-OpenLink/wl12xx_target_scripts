#!/bin/sh

wpa_cli -i p2p0 -p /var/run/wpa_supplicant/ $@
