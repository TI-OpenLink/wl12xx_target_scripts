#!/data/busybox/sh
#
# $1 = mimo/siso20/siso40
# $2 = hw type - rdl1_rdl3/rdl2_rdl4
# $3, $4 = Optional no-a-band and/or no-recovery

echo $@

# Remount system partition as rw
mount -o remount rw /system

root_path=/data/misc/wifi
hw_type_fname=${root_path}/testing_wl_hw_type.txt

wlconf_path=/system/etc/wifi/wlconf
ini_files_path=${wlconf_path}/official_inis

wl18xx_conf_bin=/system/etc/firmware/ti-connectivity/wl18xx-conf.bin

if [ "$2" != "" ]; then
    echo $2 > $hw_type_fname
fi

hw_type=`cat $hw_type_fname 2> /dev/null`

ht_mimo=0
ht_siso20=2
ht_siso40=1

#
# verify ht_mode, options are: siso20, siso40, mimo
#
if [ "$1" == "siso20" ] ; then
    ht_mode=${ht_siso20}
elif  [ "$1" == "siso40" ] ; then
    ht_mode=${ht_siso40}
elif  [ "$1" == "mimo" ] ; then
    ht_mode=${ht_mimo}
else
    echo "wlcore: not supported"
    exit 1
fi

#
# select chip type, options are: rdl2_rdl4 (mimo board), rdl1_rdl2 (hp siso board)
#
if [ "$hw_type" == "rdl2_rdl4" ] ; then # mimo board
    if [ "$ht_mode" == "$ht_mimo" ] ; then # mimo
	ini_file=WL8_System_parameters_PG2_RDL_2_4_SP_MIMO.ini
    elif [ "$ht_mode" == "$ht_siso40" ] || [ "$ht_mode" == "$ht_siso20" ] ; then # siso
	ini_file=WL8_System_parameters_PG2_RDL_2_4_SP_SISO.ini
    else
	echo "wlcore: not supported"
	exit 1
    fi
elif [ "$hw_type" == "rdl1_rdl3" ] ; then # hp siso board
    if [ "$ht_mode" == "$ht_siso40" ] || [ "$ht_mode" == "$ht_siso20" ] ; then # siso
        ini_file=WL8_System_parameters_PG2_RDL_1_3_HP_SISO.ini
    else
	echo "wlcore: not supported"
	exit 1
    fi
else
    echo "wlcore: not supported"
    exit 1
fi

cd ${wlconf_path}
wlconf -o ${wl18xx_conf_bin} -I ${ini_files_path}/${ini_file}
wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set wl18xx.ht.mode=${ht_mode}

if [ "$3" != "" ]; then
    if [ "$3" == "no-a-band" ]; then
#
# disabling A band is done by setting number_of_assembled_ant5 to 0
#
	wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set wl18xx.phy.number_of_assembled_ant5=0
    elif [ "$3" == "no-recovery" ]; then
	wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set core.recovery.no_recovery=1
    else
	echo "wlcore: not supported"
	exit 1
    fi
fi

if [ "$4" != "" ]; then
    if [ "$4" == "no-a-band" ]; then
#
# disabling A band is done by setting number_of_assembled_ant5 to 0
#
	wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set wl18xx.phy.number_of_assembled_ant5=0
    elif [ "$4" == "no-recovery" ]; then
	wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set core.recovery.no_recovery=1
    else
	echo "wlcore: not supported"
	exit 1
    fi
fi

wlconf -i ${wl18xx_conf_bin} -g | grep -i "board\|ant\|ht.mode\|recovery"

echo "wlcore: configuration ok"
exit 0
