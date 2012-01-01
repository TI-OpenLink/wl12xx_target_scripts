#!/system/bin/sh

#
# calibrate.sh
#
# calibration of the wlan device over Blaze platform
# Script takes two arguments:
# 1. INI file for calibration (depend on device and FEM, full path required)
# 2. MAC address (e.g 08:00:28:12:34:56)
#
# Copyright (C) {2011} Texas Instruments Incorporated - http://www.ti.com/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# 	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and  
# limitations under the License.
#

echo "removing current nvs file"
rm /system/etc/firmware/ti-connectivity/wl1271-nvs.bin

echo "creating new nvs file using autocalibrate command"
calibrator plt autocalibrate wlan0 /system/lib/modules/wl12xx_sdio.ko $1 /etc/firmware/ti-connectivity/wl1271-nvs.bin $2

echo "dumping nvs content:"
calibrator get dump_nvs /etc/firmware/ti-connectivity/wl1271-nvs.bin

