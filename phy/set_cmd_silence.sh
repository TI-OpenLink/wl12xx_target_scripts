#!/bin/sh
#set -x verbose #echo on
#unset verbose

#Version
version=1.0.0.1

# Command API index
API_PLT_STOP_TX=16
API_PLT_CW_SILENCE=23

_g_MacPhyApi_MailBox=0x22000
_g_MacPhyApi_MailBox_status_offset=0x34
_g_MacPhyApi_Mailbox_handleState_offset=0x38
_g_MacPhyApi_MailBox_DataOffset=0x4c
API_1_REG=0x2C100
API_handling_state_addr=0x22034

# Register set
REG_TX_CONFIG_SOURCE_CONTROL=0x34764
REG_TX1_LO_LEAK_CALIB=0x34424
REG_TX2_LO_LEAK_CALIB=0x3442C

get_version() {
	echo The tool version is: $version	
}

write_reg() {
	calibrator wlan0 wl18xx_plt phy_reg_write $1 $2
}

read_reg() {
	calibrator wlan0 wl18xx_plt phy_reg_read $1
}

usage() {
	echo "set_cmd_silence [type] [board type] [BW]"
	echo " type         - on or off"
	echo " board type   - siso or mimo"
	echo " BW           - 5G or 2.4G"
	echo " Example: set_cmd_silence on siso 5G"
	echo " To get version number use version as 'type' parameter."
}

trigger_API_int() {
	local API_id=$1
	local handleStateAddress
	local statusAddress
	echo Making the API handling status "pending"
	write_reg $API_handling_state_addr 0x1
	read_reg $API_handling_state_addr
	echo  Trigerring command  
	value_to_write_to_api_reg=$(printf "0x%x" $(($API_id*256+3)))
	#write_reg(API_1_REG,"15:0",value_to_write_to_api_reg)	
	calibrator wlan0 wl18xx_plt phy_reg_write $API_1_REG $value_to_write_to_api_reg
	#sleep 1
	echo Reading status command
	#statusAddress
	statusAddress=$(printf "0x%x" $((_g_MacPhyApi_MailBox + _g_MacPhyApi_MailBox_status_offset)))
	read_reg $statusAddress
}

API_TransmitSilence() {	
	local toneMode_offset=0x138
	local cmd_reg
	
	echo Configuring LO  source 1 and 2 to OCP registers
	write_reg $REG_TX_CONFIG_SOURCE_CONTROL 0xa
	
	echo Writing I and Q
	if [ $1 = convert ]; then
		write_reg $REG_TX1_LO_LEAK_CALIB 0x06ff06ff
	else
		write_reg $REG_TX1_LO_LEAK_CALIB 0x01000100
	fi
	write_reg $REG_TX2_LO_LEAK_CALIB 0x01000100
	
	echo Writing command parameters
	cmd_reg=$(printf "0x%x" $((_g_MacPhyApi_MailBox + toneMode_offset)))
	write_reg $cmd_reg 0x0		
	trigger_API_int $API_PLT_CW_SILENCE
}

API_StopTX() {	
	
	echo Configuring LO  source 1 and 2 to OCP registers
	write_reg $REG_TX_CONFIG_SOURCE_CONTROL 0x0
	
	echo Writing I and Q
	write_reg $REG_TX1_LO_LEAK_CALIB 0x0
	write_reg $REG_TX2_LO_LEAK_CALIB 0x0	
	
	trigger_API_int $API_PLT_STOP_TX
}


##API_TransmitSilence
#main () {
if [ "$1" = "" ] && [ "$2" = "" ] && [ "$3" = "" ]; then 
	usage
	exit 1
fi

if [ "$1" = "version" ]; then 
	get_version
	exit 1
fi
	
if [ "$1" = "on" ]; then 
	echo "Found on $2 with $3"
	if [ "$2" = "siso" -a "$3" = "2.4G" ]; then 
		API_TransmitSilence convert
	elif [ "$2" = "siso" -a "$3" = "5G" ] || [ "$2" = "mimo" -a "$3" = "2.4G" ] || [ "$2" = "mimo" -a "$3" = "5G" ]; then 
		API_TransmitSilence
	fi
elif [ "$1" = "off" ]; then 
	API_StopTX
else 
	usage	
	exit 1	
fi


