#! /bin/bash
echo "Dump LTC4015 decryption script"
echo

#Constants
RSNSI=0.004
RSNSB=0.007
RHUVCL=150000
RLUVCL=10000

echo RSNSI=$RSNSI
echo RSNSB=$RSNSB


#sudo i2cdump -y 3 0x68 w
# sudo i2cdump -y 3 0x68 w > dump_ltc4015.txt
python3 i2cdumpconvertor.py

 # function i2cget () {
 #         hex=$(sudo i2cget -y 3 0x68 $1 w)
# 		 echo ${hex:2:4}
 # }

function i2cget () {
	./i2cdumpcaсhe.sh $1
}

# function hex2binary () {
# 	if [ $# -eq 0 ]
# 	then
# 		echo "Argument(s) not supplied "
# 		echo "Usage: hex2binary"
# 	else
# 		while [ $# -ne 0 ]
# 		do
# 			DecNum=`printf "%d" $1`
# 			Binary=
# 			Number=$DecNum

# 			while [ $DecNum -ne 0 ]
# 			do
# 					Bit=$(expr $DecNum % 2)
# 					Binary=$Bit$Binary
# 					DecNum=$(expr $DecNum / 2)
# 			done
# 			echo $Binary
# 			shift
# 			unset Binary
# 		done
# 	fi
# }

function sign_hex2dec() {
    res=$(echo "ibase=16; ${1^^}" | bc)
    (( res > 32767 )) && (( res -= 65536 )) 
    echo $res
}

function i2cgetbin () {
	echo "obase=2; $(i2cgetdec $1)" | bc
}

function i2cgetdec () {
	echo "ibase=16; $(i2cget $1)" | bc
}

function checkbit () {
	var=$(echo "ibase=16; $2" | bc)
	if [[ $1 -eq 0 ]]
	then
		echo $((($var & 0x0001) != 0))
	elif [[ $1 -eq 1 ]]
	then
		echo $((($var & 0x0002) != 0))
	elif [[ $1 -eq 2 ]]
	then
		echo $((($var & 0x0004) != 0))
	elif [[ $1 -eq 3 ]]
	then
		echo $((($var & 0x0008) != 0))
	elif [[ $1 -eq 4 ]]
	then
		echo $((($var & 0x0010) != 0))
	elif [[ $1 -eq 5 ]]
	then
		echo $((($var & 0x0020) != 0))
	elif [[ $1 -eq 6 ]]
	then
		echo $((($var & 0x0040) != 0))
	elif [[ $1 -eq 7 ]]
	then
		echo $((($var & 0x0080) != 0))
	elif [[ $1 -eq 8 ]]
	then
		echo $((($var & 0x0100) != 0))
	elif [[ $1 -eq 9 ]]
	then
		echo $((($var & 0x0200) != 0))
	elif [[ $1 -eq 10 ]]
	then
		echo $((($var & 0x0400) != 0))
	elif [[ $1 -eq 11 ]]
	then
		echo $((($var & 0x0800) != 0))
	elif [[ $1 -eq 12 ]]
	then
		echo $((($var & 0x1000) != 0))
	elif [[ $1 -eq 13 ]]
	then
		echo $((($var & 0x2000) != 0))
	elif [[ $1 -eq 14 ]]
	then
		echo $((($var & 0x4000) != 0))
	elif [[ $1 -eq 15 ]]
	then
		echo $((($var & 0x8000) != 0))
	fi
}



#*****************************************************************************************
#*****************************************************************************************
#*****************************************************************************************


adr=0x01
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VBAT_LO_ALERT_LIMIT (Sub-Address 0x01, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x02
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VBAT_HI_ALERT_LIMIT (Sub-Address 0x02, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x03
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VIN_LO_ALERT_LIMIT (Sub-Address 0x03, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x04
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VIN_HI_ALERT_LIMIT (Sub-Address 0x04, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x05
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VSYS_LO_ALERT_LIMIT (Sub-Address 0x05, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x06
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VSYS_HI_ALERT_LIMIT (Sub-Address 0x06, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x07
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "IIN_HI_ALERT_LIMIT (Sub-Address 0x07, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x08
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "IBAT_LO_ALERT_LIMIT (Sub-Address 0x08, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x09
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "DIE_TEMP_HI_ALERT_LIMIT (Sub-Address 0x09, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x0A
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "BSR_HI_ALERT_LIMIT (Sub-Address 0x0A, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x0B
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "NTC_RATIO_HI_ALERT_LIMIT (Sub-Address 0x0B, Bits 15:0,R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x0C
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "NTC_RATIO_LO_ALERT_LIMIT (Sub-Address 0x0C, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x0D
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "EN_LIMIT_ALERTS (Sub-Address 0x0D, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

			# en_meas_sys_valid_alert (Sub-Address 0x0D, Bit 15, R/W)
			# en_qcount_lo_alert (Sub-Address 0x0D, Bit 13, R/W)
			# en_qcount_hi_alert (Sub-Address 0x0D, Bit 12, R/W)
			# en_vbat_lo_alert (Sub-Address 0x0D, Bit 11, R/W)
			# en_vbat_hi_alert (Sub-Address 0x0D, Bit 10, R/W)
			# en_vin_lo_alert (Sub-Address 0x0D, Bit 9, R/W)
			# en_vin_hi_alert (Sub-Address 0x0D, Bit 8, R/W)
			# en_vsys_lo_alert (Sub-Address 0x0D, Bit 7, R/W)
			# en_vsys_hi_alert (Sub-Address 0x0D, Bit 6, R/W)
			# en_iin_hi_alert (Sub-Address 0x0D, Bit 5, R/W)
			# en_ibat_lo_alert (Sub-Address 0x0D, Bit 4, R/W)
			# en_die_temp_hi_alert (Sub-Address 0x0D, Bit 3, R/W)
			# en_bsr_hi_alert (Sub-Address 0x0D, Bit 2, R/W)
			# en_ntc_ratio_hi_alert (Sub-Address 0x0D, Bit 1, R/W)
			# en_ntc_ratio_lo_alert (Sub-Address 0x0D, Bit 0, R/W)
	}
fi

adr=0x0E
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "EN_CHARGER_STATE_ALERTS (Sub-Address 0x0E, Bits 10:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

			# en_equalize_charge_alert (Sub-Address 0x0E, Bit 10, R/W)
			# en_absorb_charge_alert (Sub-Address 0x0E, Bit 9, R/W)
			# en_charger_suspended_alert (Sub-Address 0x0E, Bit 8, R/W)
			# en_precharge_alert (Sub-Address 0x0E, Bit 7, R/W)
			# en_cc_cv_charge_alert (Sub-Address 0x0E, Bit 6, R/W)
			# en_ntc_pause_alert (Sub-Address 0x0E, Bit 5, R/W)
			# en_timer_term_alert (Sub-Address 0x0E, Bit 4, R/W)
			# en_c_over_x_term_alert (Sub-Address 0x0E, Bit 3, R/W)
			# en_max_charge_time_fault_alert (Sub-Address 0x0E, Bit 2, R/W)
			# en_bat_missing_fault_alert (Sub-Address 0x0E, Bit 1, R/W)
			# en_bat_short_fault_alert (Sub-Address 0x0E, Bit 0, R/W)
	}
fi

adr=0x0F
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "EN_CHARGE_STATUS_ALERTS (Sub-Address 0x0F, Bits 3:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

			# en_vin_uvcl_active_alert (Sub-Address 0x0F, Bit 3, R/W)
			# en_iin_limit_active_alert (Sub-Address 0x0F, Bit 2, R/W)
			# en_constant_current_alert (Sub-Address 0x0F, Bit 1, R/W)
			# en_constant_voltage_alert (Sub-Address 0x0F, Bit 0, R/W)
	}
fi

adr=0x10
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "QCOUNT_LO_ALERT_LIMIT (Sub-Address 0x10, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x11
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "QCOUNT_HI_ALERT_LIMIT (Sub-Address 0x11, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x12
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "QCOUNT_PRESCALE_FACTOR (Sub-Address 0x12, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- This 16-bit word along with RSNSB is used to set the qLSB value of Coulomb counter accumulator, QCOUNT."

		QCOUNT_PRESCALE_FACTOR=$(i2cgetdec $adr)
		qLSB=$(printf %.3f $(echo $QCOUNT_PRESCALE_FACTOR/8333.33*$RSNSB | bc -l))
		echo - qLSB = $qLSB "s(COULOMBS)"
	}
fi

adr=0x13
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "QCOUNT (Sub-Address 0x13, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- This 16-bit word reports the current value of Coulomb counter accumulator, QCOUNT. This register can be written to represent a known state of charge of the battery."

		QCOUNT_PRESCALE_FACTOR=$(i2cgetdec $adr)
		qLSB=$(printf %.3f $(echo $QCOUNT_PRESCALE_FACTOR/8333.33*$RSNSB | bc -l))
		echo - qLSB = $qLSB "s(COULOMBS)"
	}
fi

adr=0x14
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CONFIG_BITS (Sub-Address 0x14, Bits 8:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

		# suspend_charger (Sub-Address 0x14, Bit 8, R/W)
		# run_bsr (Sub-Address 0x14, Bit 5, R/W)
		# force_meas_sys_on (Sub-Address 0x14, Bit 4, R/W)
		# mppt_en_i2c (Sub-Address 0x14, Bit 3, R/W)
		# en_qcount (Sub-Address 0x14, Bit 2, R/W)
	}
fi

adr=0x15
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "IIN_LIMIT_SETTING (Sub-Address 0x15, Bits 5:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- These 6 bits control the target input current limit setting. The input current will be regulated to a maximum value"

		IIN_LIMIT_SETTING=$(i2cgetdec $adr)
		IIN_LIMIT=$(printf %.3f $(echo $(($IIN_LIMIT_SETTING+1))*0.0005/$RSNSI | bc -l))
		echo - IIN_LIMIT = $IIN_LIMIT A
	}
fi

adr=0x16
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VIN_UVCL_SETTING (Sub-Address 0x16, Bits 7:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

		VIN_UVCL_SETTING=$(i2cgetdec $adr)
		VIN_UVCL=$(printf %.3f $(echo $(($VIN_UVCL_SETTING+1))*0.004687 | bc -l))
		echo - VIN_UVCL = $VIN_UVCL V
		VIN_SETTING=$(printf %.3f $(echo $VIN_UVCL*$(($RHUVCL+$RLUVCL))/$RLUVCL | bc -l))
		echo - VIN_SETTING = $VIN_SETTING V
	}
fi

adr=0x19
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "ARM_SHIP_MODE (Sub-Address 0x19, Bits 15:0, R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x1A
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "ICHARGE_TARGET (Sub-Address 0x1A, bits 4:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x1B
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VCHARGE_SETTING (Sub-Address 0x1B, bits 5:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- if Li-Ion batteries:"
		VCHARGE_SETTING=$(($(i2cgetdec $adr) & $((2#11111))))
		VCHARGE_SETTING=$(echo $(printf %.3f $(echo $VCHARGE_SETTING/80.0 | bc -l)) + 3.8125 | bc)
		echo - - VCHARGE_SETTING = $VCHARGE_SETTING	


		echo "- if LiFePO4 batteries:"
		VCHARGE_SETTING=$(($(i2cgetdec $adr) & $((2#11111))))
		VCHARGE_SETTING=$(echo $(printf %.3f $(echo $VCHARGE_SETTING/80.0 | bc -l)) + 3.4125 | bc)
		echo - - VCHARGE_SETTING = $VCHARGE_SETTING	

		echo "- if lead-acid batteries at 25°C"
		VCHARGE_SETTING=$(($(i2cgetdec $adr) & $((2#11111))))
		VCHARGE_SETTING=$(echo $(printf %.3f $(echo $VCHARGE_SETTING/105.0 | bc -l)) + 2.0 | bc)
		echo - - VCHARGE_SETTING = $VCHARGE_SETTING	
	}
fi

adr=0x2A
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VABSORB_DELTA (Sub-Address 0x2A, bits 5:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x2C
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VEQUALIZE_DELTA (Sub-Address 0x2C, Bits 5:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x1C
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "C_OVER_X_THRESHOLD (Sub-Address 0x1C, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data

		# ibatadc=$(sign_hex2dec $data)
		# ibat=$(printf %.2f $(echo $ibatadc*0.00000146487/$RSNSB | bc -l))
		# echo - IBAT = $ibat A
	}
fi

adr=0x1D
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "MAX_CV_TIME (Sub-Address 0x1D, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x2B
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "MAX_ABSORB_TIME (Sub-Address 0x2B, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x2D
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "EQUALIZE_TIME (Sub-Address 0x2D, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x1E
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "MAX_CHARGE_TIME (Sub-Address 0x1E, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x2E
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "LIFEP04_RECHARGE_THRESHOLD (Sub-Address 0x2E, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x24
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "JEITA_Tn (Sub-Address 0x1F Through 0x24, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x25
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VCHARGE_JEITA_6_5 (Sub-Address 0x25, Bits 9:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x26
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VCHARGE_JEITA_4_3_2 (Sub-Address 0x26, Bits 14:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x27
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "ICHARGE_JEITA_6_5 (Sub-Address 0x27, Bits 9:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x28
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "ICHARGE_JEITA_4_3_2 (Sub-Address 0x28, Bits 14:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi


adr=0x29
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CHARGER_CONFIG_BITS (Sub-Address 0x29, Bits 2:0, Fixed: R, Programmable: R/W)"
		echo "- This register consists of individual battery charger configuration bits which enable specific battery charger functions."
		
		data=$(i2cget $adr)
		echo - $adr: $data

		if [[ $(checkbit 2 $data) == 1 ]]; then
			echo "- - en_c_over_x_term (Sub-Address 0x29, Bit 2, Fixed: R, Programmable: R/W)"
			echo "- - - For lithium chemistries, setting this bit enables C/x charge termination, in conjunction with C_OVER_X_THRESHOLD. For lead-acid batteries, en_c_over_x_term is ignored. Default is 0."
		fi

		if [[ $(checkbit 1 $data) == 1 ]]; then
			echo "- - en_lead_acid_temp_comp (Sub-Address 0x29, Bit 1, Fixed: R, Programmable: R/W)"
			echo "- - - For lead-acid batteries, setting this bit enables temperature compensated charge voltage levels as detailed in the Lead-Acid Temperature Compensated Charging section. Default is 1 for lead-acid batteries. For lithium chemistries, en_lead_acid_temp_comp is ignored. "
		fi

		if [[ $(checkbit 0 $data) == 1 ]]; then
			echo "- - en_jeita (Sub-Address 0x29, Bit 0, Fixed: R, Programmable: R/W)"
			echo "- - - For lithium chemistries, setting this bit enables the JEITA temperature qualified algorithm as detailed in the JEITA Temperature Qualified Charging section. The charging parameters are set by JEITA_Tn, vcharge_jeita_n, and icharge_jeita _n. Default is 1 for lithium chemistries. For lead-acid batteries, en_jeita is ignored."
		fi
	}
fi

adr=0x30
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "MAX_CHARGE_TIMER (Sub-Address 0x30, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data 
	}
fi

adr=0x31
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CV_TIMER (Sub-Address 0x31, Bits 10:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data 
	}
fi

adr=0x32
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "ABSORB_TIMER (Sub-Address 0x32, Bits 10:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data 
	}
fi

adr=0x33
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "EQUALIZE_TIMER (Sub-Address 0x33, Bits 15:0, Fixed: R, Programmable: R/W)"

		data=$(i2cget $adr)
		echo - $adr: $data 
	}
fi

adr=0x34
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CHARGER_STATE (Sub-Address 0x34, Bits 10:0, R)"
		echo "- This register consists of individual battery charger state indicator bits. Individual bits are mutually exclusive (a maximum of one bit is asserted at any given time). See the section Battery Charger Algorithms for more information regarding the charger states."
		
		data=$(i2cget $adr)
		echo - $adr: $data

		if [[ $(checkbit 10 $data) == 1 ]]; then
			echo "- - equalize_charge (Sub-Address 0x34, Bit 10, R)"
		fi
		if [[ $(checkbit 9 $data) == 1 ]]; then
			echo "- - absorb_charge (Sub-Address 0x34, Bit 9, R)"
		fi
		if [[ $(checkbit 8 $data) == 1 ]]; then
			echo "- - charger_suspended (Sub-Address 0x34, Bit 8, R)"
		fi
		if [[ $(checkbit 7 $data) == 1 ]]; then
			echo "- - precharge (Sub-Address 0x34, Bit 7, R)"
		fi
		if [[ $(checkbit 6 $data) == 1 ]]; then
			echo "- - cc_cv_charge (Sub-Address 0x34, Bit 6, R)"
		fi
		if [[ $(checkbit 5 $data) == 1 ]]; then
			echo "- - ntc_pause (Sub-Address 0x34, Bit 5, R)"
		fi
		if [[ $(checkbit 4 $data) == 1 ]]; then
			echo "- - timer_term (Sub-Address 0x34, Bit 4, R)"
		fi
		if [[ $(checkbit 3 $data) == 1 ]]; then
			echo "- - c_over_x_term (Sub-Address 0x34, Bit 3, R)"
		fi
		if [[ $(checkbit 2 $data) == 1 ]]; then
			echo "- - max_charge_time_fault (Sub-Address 0x34, Bit 2, R)"
		fi
		if [[ $(checkbit 1 $data) == 1 ]]; then
			echo "- - bat_missing_fault (Sub-Address 0x34, Bit 1, R)"
		fi
		if [[ $(checkbit 0 $data) == 1 ]]; then
			echo "- - bat_short_fault (Sub-Address 0x34, Bit 0, R)"
		fi
	}
fi

adr=0x35
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CHARGE_STATUS (Sub-Address 0x35, Bits 3:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		if [[ $(checkbit 3 $data) == 1 ]]; then
			echo "- - vin_uvcl_active (Sub-Address 0x35, Bit 3, R)"
		fi
		if [[ $(checkbit 2 $data) == 1 ]]; then
			echo "- - iin_limit_active (Sub-Address 0x35, Bit 2, R)"
		fi
		if [[ $(checkbit 1 $data) == 1 ]]; then
			echo "- - constant_current (Sub-Address 0x35, Bit 1, R)"
		fi
		if [[ $(checkbit 0 $data) == 1 ]]; then
			echo "- - constant_voltage (Sub-Address 0x35, Bit 0, R)"
		fi
	}
fi


adr=0x36
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "LIMIT_ALERTS (Sub-Address 0x36, Bits 15:0, R/Clear)"

		data=$(i2cget $adr)
		echo - $adr: $data

			# meas_sys_valid_alert (Sub-Address 0x36, Bit 15, R/Clear)
			# qcount_lo_alert (Sub-Address 0x36, Bit 13, R/Clear)
			# qcount_hi_alert (Sub-Address 0x36, Bit 12, R/Clear)
			# vbat_lo_alert (Sub-Address 0x36, Bit 11, R/Clear)
			# vbat_hi_alert (Sub-Address 0x36, Bit 10, R/Clear)
			# vin_lo_alert (Sub-Address 0x36, Bit 9, R/Clear)
			# vin_hi_alert (Sub-Address 0x36, Bit 8, R/Clear)
			# vsys_lo_alert (Sub-Address 0x36, Bit 7, R/Clear)
			# vsys_hi_alert (Sub-Address 0x36, Bit 6, R/Clear)
			# iin_hi_alert (Sub-Address 0x36, Bit 5, R/Clear)
			# ibat_lo_alert (Sub-Address 0x36, Bit 4, R/Clear)
			# die_temp_hi_alert (Sub-Address 0x36, Bit 3, R/Clear)
			# bsr_hi_alert (Sub-Address 0x36, Bit 2, R/Clear)
			# ntc_ratio_hi_alert (Sub-Address 0x36, Bit 1, R/Clear)
			# ntc_ratio_lo_alert (Sub-Address 0x36, Bit 0, R/Clear)
	}
fi

adr=0x37
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CHARGER_STATE_ALERTS (Sub-Address 0x37, Bits 10:0, R/Clear)"

		data=$(i2cget $adr)
		echo - $adr: $data

			# equalize_charge_alert (Sub-Address 0x37, Bit 10, R/Clear)
			# absorb_charge_alert (Sub-Address 0x37, Bit 9, R/Clear)
			# charger_suspended_alert (Sub-Address 0x37, Bit 8, R/Clear)
			# precharge_alert (Sub-Address 0x37, Bit 7, R/Clear)
			# cc_cv_charge_alert (Sub-Address 0x37, Bit 6, R/Clear)
			# ntc_pause_alert (Sub-Address 0x37, Bit 5, R/Clear)
			# timer_term_alert (Sub-Address 0x37, Bit 4, R/Clear)
			# c_over_x_term_alert (Sub-Address 0x37, Bit 3, R/Clear)
			# max_charge_time_fault_alert (Sub-Address 0x37, Bit 2, R/Clear)
			# bat_missing_fault_alert (Sub-Address 0x37, Bit 1, R/Clear)
			# bat_short_fault_alert (Sub-Address 0x37, Bit 0, R/Clear)
	}
fi

adr=0x38
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CHARGE_STATUS_ALERTS (Sub-Address 0x38, Bits 3:0, R/Clear)"

		data=$(i2cget $adr)
		echo - $adr: $data

			# vin_uvcl_active_alert (Sub-Address 0x38, Bit 3, R/Clear)
			# iin_limit_active_alert (Sub-Address 0x38, Bit 2, R/Clear)
			# constant_current_alert (Sub-Address 0x38, Bit 1, R/Clear)
			# constant_voltage_alert (Sub-Address 0x38, Bit 0, R/Clear)
	}
fi

adr=0x39
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "SYSTEM_STATUS (Sub-Address 0x39, Bits 13:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		if [[ $(checkbit 13 $data) == 1 ]]; then
			echo "- - charger_enabled (Sub-Address 0x39, Bit 13, R)"
		fi
		if [[ $(checkbit 11 $data) == 1 ]]; then
			echo "- - mppt_en_pin (Sub-Address 0x39, Bit 11, R)"
		fi
		if [[ $(checkbit 10 $data) == 1 ]]; then
			echo "- - equalize_req (Sub-Address 0x39, Bit 10, R)"
		fi
		if [[ $(checkbit 9 $data) == 1 ]]; then
			echo "- - drvcc_good (Sub-Address 0x39, Bit 9, R)"
		fi
		if [[ $(checkbit 8 $data) == 1 ]]; then
			echo "- - cell_count_error (Sub-Address 0x39, Bit 8, R)"
		fi
		if [[ $(checkbit 6 $data) == 1 ]]; then
			echo "- - ok_to_charge (Sub-Address 0x39, Bit 6, R)"
		fi
		if [[ $(checkbit 5 $data) == 1 ]]; then
			echo "- - no_rt (Sub-Address 0x39, Bit 5, R)"
		fi
		if [[ $(checkbit 4 $data) == 1 ]]; then
			echo "- - thermal_shutdown (Sub-address 0x39, Bit 4, R)"
		fi
		if [[ $(checkbit 3 $data) == 1 ]]; then
			echo "- - vin_ovlo (Sub-address 0x39, Bit 3, R)"
		fi
		if [[ $(checkbit 2 $data) == 1 ]]; then
			echo "- - vin_gt_vbat (Sub-Address 0x39, Bit 2, R)"
		fi
		if [[ $(checkbit 1 $data) == 1 ]]; then
			echo "- - intvcc_gt_4p3v (Sub-Address 0x39, Bit 1, R)"
		fi
		if [[ $(checkbit 0 $data) == 1 ]]; then
			echo "- - intvcc_gt2p8v (Sub-Address 0x39, Bit 0, R)"
		fi
	}
fi

adr=0x3A
	{
		echo "*****************************************************************************"
		echo "VBAT (Sub-Address 0x3A, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		vbatadc=$(i2cgetdec $adr)
		vbat=$(printf %.2f $(echo $vbatadc*0.000192264 | bc -l))
		echo - VBAT = $vbat V
	}

adr=0x3B
	{
		echo "*****************************************************************************"
		echo "VIN (Sub-Address 0x3B, Bits 15:0, R)" 

		data=$(i2cget $adr)
		echo - $adr: $data

		vinadc=$(i2cgetdec $adr)
		vin=$(printf %.2f $(echo $vinadc*0.001648 | bc -l))
		echo - VIN = $vin V

	}

adr=0x3C
	{
		echo "*****************************************************************************"
		echo "VSYS (Sub-Address 0x3C, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		vsysadc=$(i2cgetdec $adr)
		vsys=$(printf %.2f $(echo $vsysadc*0.001648 | bc -l))
		echo - VSYS = $vsys V
	}

adr=0x3D
	{
		echo "*****************************************************************************"
		echo "IBAT (Sub-Address 0x3D, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		ibatadc=$(sign_hex2dec $data)
		ibat=$(printf %.2f $(echo $ibatadc*0.00000146487/$RSNSB | bc -l))
		echo - IBAT = $ibat A
	}


adr=0x3E
	{
		echo "*****************************************************************************"
		echo "IIN (Sub-Address 0x3E, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		iinadc=$(i2cgetdec $adr)
		iin=$(printf %.2f $(echo $iinadc*0.00000146487/$RSNSI | bc -l))
		echo - IIN = $iin A
	}


adr=0x3F
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "DIE_TEMP (Sub-Address 0x3F, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		DIE_TEMP=$(i2cgetdec $adr)
		temperature=$(printf %.2f $(echo $(($DIE_TEMP-12010))/45.6 | bc -l))
		echo -  LTC4015 temperature: $temperature ^C
	}
fi

adr=0x40
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "NTC_RATIO (Sub-Address 0x40, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x41
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "BSR (Sub-Address 0x41, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x42
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "JEITA_ REGION (Sub-Address 0x42, Bits 2:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x43
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "CHEM_AND_CELLS (Sub-Address 0x43, Bits 11:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		CHEM_AND_CELLS=$(i2cgetbin $adr)
		echo - CHEM_AND_CELLS = $CHEM_AND_CELLS

		CHEM_AND_CELLS_DEC=$(i2cgetdec $adr)

		echo "- - chem (Sub-Address 0x43, Bits 11:8, R)"
		CHEM=$(($(($CHEM_AND_CELLS_DEC & $((2#111100000000))))>>8))
		# echo - - - CHEM bin = $(echo "obase=2;$CHEM" | bc)
		
		if [[ $CHEM -eq 0x0 ]]
		then
			echo "- - - Li-Ion Programmable"
		elif [[ $CHEM -eq 0x1 ]]
		then
			echo "- - - Li-Ion Fixed 4.2V/cell"
		elif [[ $CHEM -eq 0x2 ]]
		then
			echo "- - - Li-Ion Fixed 4.1V/cell"
		elif [[ $CHEM -eq 0x3 ]]
		then
			echo "- - - Li-Ion Fixed 4.0V/cell"
		elif [[ $CHEM -eq 0x4 ]]
		then
			echo "- - - LiFePO4 Programmable"
		elif [[ $CHEM -eq 0x5 ]]
		then
			echo "- - - LiFePO4 Fixed Fast Charge"
		elif [[ $CHEM -eq 0x6 ]]
		then
			echo "- - - LiFePO4 Fixed 3.6V/cell"
		elif [[ $CHEM -eq 0x7 ]]
		then
			echo "- - - Lead-Acid Fixed"
		elif [[ $CHEM -eq 0x8 ]]
		then
			echo "- - - Lead-Acid Programmable"
		fi

		echo "- - cells (Sub-Address 0x43, Bits 3:0, R)"
		CELLS=$(($CHEM_AND_CELLS_DEC & $((2#1111))))
		# echo - - - CELLS bin = $(echo "obase=2;$CELLS" | bc)

		if [[ $CELLS -eq 0x0 ]]
		then
			echo "- - - NUMBER OF CELLS: Invalid"
		elif [[ $CELLS -eq 0x1 ]]
		then
			echo "- - - NUMBER OF CELLS: 1"
		elif [[ $CELLS -eq 0x2 ]]
		then
			echo "- - - NUMBER OF CELLS: 2"
		elif [[ $CELLS -eq 0x3 ]]
		then
			echo "- - - NUMBER OF CELLS: 3"
		elif [[ $CELLS -eq 0x4 ]]
		then
			echo "- - - NUMBER OF CELLS: 4"
		elif [[ $CELLS -eq 0x5 ]]
		then
			echo "- - - NUMBER OF CELLS: 5"
		elif [[ $CELLS -eq 0x6 ]]
		then
			echo "- - - NUMBER OF CELLS: 6"
		elif [[ $CELLS -eq 0x7 ]]
		then
			echo "- - - NUMBER OF CELLS: 7"
		elif [[ $CELLS -eq 0x8 ]]
		then
			echo "- - - NUMBER OF CELLS: 8"
		elif [[ $CELLS -eq 0x9 ]]
		then
			echo "- - - NUMBER OF CELLS: 9"
		elif [[ $CELLS -eq 0xA ]]
		then
			echo "- - - NUMBER OF CELLS: Invalid"
		elif [[ $CELLS -eq 0xB ]]
		then
			echo "- - - NUMBER OF CELLS: Invalid"
		elif [[ $CELLS -eq 0xC ]]
		then
			echo "- - - NUMBER OF CELLS: 12 (Lead-acid only)"
		fi
	}
fi

adr=0x44
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "ICHARGE_DAC (Sub-Address 0x44, Bits 4:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		ICHARGE_DAC=$(i2cgetdec $adr)
		ICHARGE_DAC=$(($ICHARGE_DAC & $((2#1111))))
		ICHARGE_DAC=$(printf %.3f $(echo $(($ICHARGE_DAC+1))*0.001/$RSNSB | bc -l))
		echo - ICHARGE_DAC = $ICHARGE_DAC A
	}
fi

adr=0x45
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VCHARGE_DAC (Sub-Address 0x45, Bits 5:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data
	}
fi

adr=0x46
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "IIN_LIMIT_DAC (Sub-Address 0x46, Bits 5:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- This register represents the actual input current limit setting applied to the input current limit reference DAC. This register follows IIN_LIMIT_SETTING."
	}
fi

adr=0x47
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "VBAT_FILT (Sub-Address 0x47, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- Digitally filtered two’s complement ADC measurement result for battery voltage."
	}
fi

adr=0x48
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "ICHARGE_BSR (Sub-Address 0x48, Bits 15:0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- This 16-bit two's complement word is the value of IBAT (0x3D) used in calculating BSR."
	}
fi

adr=0x4A
if [[ $(i2cgetdec $adr) > 0 ]]; then
	{
		echo "*****************************************************************************"
		echo "TELEMETRY_VALID (Sub-Address 0x4A, Bit 0, R)"

		data=$(i2cget $adr)
		echo - $adr: $data

		echo "- This bit being set to 1 indicates the output of the LTC4015's telemetry system is valid."
	}
fi
