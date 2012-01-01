#!/system/bin/sh

MOUNT=/system/bin/mount

$MOUNT -o remount -w /dev/block/platform/omap/omap_hsmmc.1/by-name/system
$MOUNT -o remount -w /dev/block/platform/omap/omap_hsmmc.1/by-name/userdata
