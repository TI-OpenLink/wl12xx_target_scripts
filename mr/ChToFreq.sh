CHANNEL=$1
CHANNEL_FREQ=0

if [ "$CHANNEL" -ge 149] ; then 
	let "CHANNEL_FREQ = (($CHANNEL - 149) * 5) + 5745"
elif [ "$CHANNEL" -ge 36 ] ; then 
	let "CHANNEL_FREQ = (($CHANNEL - 36) * 5) + 5180"
elif [ "$CHANNEL" -ge 1 ] ; then 
	let "CHANNEL_FREQ = (($CHANNEL - 1) * 5) + 2412"
else
	echo "CH in not in range" 
fi

echo $CHANNEL_FREQ


