#!/system/bin/sh

MOUNT=/system/bin/mount

$MOUNT -o remount -r /dev/block/platform/omap/omap_hsmmc.1/by-name/system
$MOUNT -o remount -r /dev/block/platform/omap/omap_hsmmc.1/by-name/userdata
