#!/data/busybox/sh
#
# $1 = mimo/siso
# $2 = hw type - com8/rdl7/etc... (optional)

root_path=/data/misc/wifi
load_wlcore_link_fname=${root_path}/load_wlcore.sh
hw_type_fname=${root_path}/testing_wl_hw_type.txt

if [ "$2" != "" ]; then
    echo $2 > $hw_type_fname
fi

hw_type=`cat $hw_type_fname 2> /dev/null`
load_wlcore_fname=${root_path}/load_wlcore_${hw_type}_${1}.sh
 
if [ ! -f "$load_wlcore_fname" ]; then
    echo "wlcore error: no such configuration (hw: $hw_type, $1)"
    exit 1
fi

if [ -f $load_wlcore_link_fname ] ; then
    rm -f $load_wlcore_link_fname
fi

ln -sf $load_wlcore_fname $load_wlcore_link_fname

if [ $? != 0 ]; then
    echo "wlcore error: link failure"
    exit 1
fi

echo "wlcore: configuration ok ($load_wlcore_fname)"
exit 0

