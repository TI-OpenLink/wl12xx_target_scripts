#!/data/busybox/sh
#
# $1 = mimo/siso
# $2 = hw type - com8/rdl7/etc... (optional)

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

if [ "$hw_type" == "dvp" ]; then
    if [ "$ht_mode" != "$ht_mimo" ]; then
	ini_file=WL8_System_parameters_PG2_RDL_1_5_DVP.ini
    else
	ini_file=WL8_System_parameters_PG2_RDL_2_7_DVP.ini
    fi
elif [ "$hw_type" == "hdk_rdl1_rdl5" ]; then
    if [ "$ht_mode" != "$ht_mimo" ]; then
	ini_file=WL8_System_parameters_PG2_RDL_1_5_HDK.ini
    else
	echo "wlcore: not supported"
	exit 1
    fi
elif [ "$hw_type" == "hdk_rdl2_rdl7" ] || [ "$hw_type" == "hdk" ]; then
    if [ "$ht_mode" != "$ht_mimo" ]; then
        ini_file=WL8_System_parameters_PG2_RDL_1_5_HDK.ini
    else
        ini_file=WL8_System_parameters_PG2_RDL_2_7_HDK.ini
    fi
else
    echo "wlcore: not supported"
    exit 1
fi

cd ${wlconf_path}
wlconf -o ${wl18xx_conf_bin} -I ${ini_files_path}/${ini_file}
wlconf -i ${wl18xx_conf_bin} -o ${wl18xx_conf_bin} --set wl18xx.ht.mode=${ht_mode}
wlconf -i ${wl18xx_conf_bin} -g | grep -i "board\|ant\|ht.mode"

echo "wlcore: configuration ok"
exit 0

