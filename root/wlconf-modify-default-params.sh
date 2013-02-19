wlconf_path=/usr/sbin/wlconf
wlconf_scripts_path=/usr/share/wl18xx/scripts/wlconf
wl18xx_conf_bin=/lib/firmware/ti-connectivity/wl18xx-conf.bin

cd ${wlconf_path}
# Modify Rx interrupt pacing params for better CPU utilization
./wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set core.rx.irq_pkt_threshold=4
./wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set core.rx.irq_timeout=1200


