CHANNEL_FREQ=$1
echo $CHANNEL_FREQ
CHANNEL=0

if [ "$CHANNEL_FREQ" -ge 5745 ] ; then 
	let "CHANNEL = (($CHANNEL_FREQ - 5745) / 5) + 149"
elif [ "$CHANNEL_FREQ" -ge 5180 ] ; then 
	let "CHANNEL = (($CHANNEL_FREQ - 5180) / 5) + 36"
elif [ "$CHANNEL_FREQ" -ge 2412 ] ; then 
	let "CHANNEL = (($CHANNEL_FREQ - 2412) / 5) + 1"
else
	echo "FREQ in not in range" 
fi

echo $CHANNEL


