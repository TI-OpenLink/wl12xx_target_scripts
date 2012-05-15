#!/system/bin/sh
echo
echo ------- DRIVER STATISTICS -------
cat /sys/kernel/debug/ieee80211/`ls /sys/kernel/debug/ieee80211/`/wlcore/driver_state
echo
echo
echo ------- FIRMWARE STATISTICS -------
echo
cd /sys/kernel/debug/ieee80211/`ls /sys/kernel/debug/ieee80211/`/wlcore/wl18xx/fw_stats/
for f in *
do
echo "$f -" `cat $f`
done
echo
echo ------- END -------
cd /
