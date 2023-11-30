#! /bin/bash
echo "Dump LTC4015 decryption script"
echo

#Constants
RSNSI=0.004
RSNSB=0.007

echo RSNSI=$RSNSI
echo RSNSB=$RSNSB


#sudo i2cdump -y 3 0x68 w

# function i2cget () {
#         sudo i2cget -y 3 0x68 $1 w
# }

function i2cget () {
	./i2cdumpcaсhe.sh $1
}

function hex2binary () {
	if [ $# -eq 0 ]
	then
		echo "Argument(s) not supplied "
		echo "Usage: hex2binary"
	else
		while [ $# -ne 0 ]
		do
			DecNum=`printf "%d" $1`
			Binary=
			Number=$DecNum

			while [ $DecNum -ne 0 ]
			do
					Bit=$(expr $DecNum % 2)
					Binary=$Bit$Binary
					DecNum=$(expr $DecNum / 2)
			done
			echo $Binary
			shift
			unset Binary
		done
	fi
}

function sign_hex2dec() {
    res=$(printf "%d" "$1")
    (( res > 32767 )) && (( res -= 65536 )) 
    echo $res
}



#*****************************************************************************************
#*****************************************************************************************
#*****************************************************************************************
#*****************************************************************************************
#*****************************************************************************************
#*****************************************************************************************
#*****************************************************************************************



echo
echo "*****************************************************************************************"
# CHARGER_CONFIG_BITS (Sub-Address 0x29, Bits 2:0, Fixed: R, Programmable: R/W)
	charger_config_bits_hex=$(i2cget 0x29)
	charger_config_bits_bin=$(hex2binary $charger_config_bits_hex)
	echo CHARGER_CONFIG_BITS 0x29 hex = $charger_config_bits_hex bin = charger_config_bits_bin. 
	echo This register consists of individual battery charger configuration bits which enable specific battery charger functions.
	charger_config_bits_bin_rev=$(echo $charger_config_bits_bin | rev)

	en_jeita=${charger_config_bits_bin_rev:0:1}
	if [[ $en_jeita -eq 1 ]]
	then
		echo
		echo "For lithium chemistries, setting this bit enables the JEITA temperature qualified algorithm as detailed in the JEITA Temperature Qualified Charging section. The charging parameters are set by JEITA_Tn, vcharge_jeita_n, and i charge_jeita _n. Default is 1 for lithium chemistries. For lead-acid batteries, en_jeita is ignored."
	fi
	en_lead_acid_temp_comp=${charger_config_bits_bin_rev:1:1}
	if [[ $en_lead_acid_temp_comp -eq 1 ]]
	then
		echo
			echo "For lead-acid batteries, setting this bit enables temperature compensated charge voltage levels as detailed in the Lead-Acid Temperature Compensated Charging section. Default is 1 for lead-acid batteries. For lithium chemistries, en_lead_acid_temp_comp is ignored."
	fi
	en_c_over_x_term=${charger_config_bits_bin_rev:2:1}
	if [[ $en_c_over_x_term -eq 1 ]]
	then
		echo
			echo "For lithium chemistries, setting this bit enables C/x charge termination, in conjunction with C_OVER_X_THRESHOLD. For lead-acid batteries, en_c_over_x_term is ignored. Default is 0."
	fi

echo
echo "*****************************************************************************************"
#CHARGER_STATE 0x34
charger_state_hex=$(i2cget 0x34)
charger_state_bin=$(hex2binary $charger_state_hex)
echo CHARGER_STATE hex = $charger_state_hex bin = $charger_state_bin
charger_state_bin_rev=$(echo $charger_state_bin | rev)

bat_short_fault=${charger_state_bin_rev:0:1}
if [[ $bat_short_fault -eq 1 ]]
then
	echo
        echo "The LTC4015 is in battery short fault state due to a shorted battery detected"
fi
bat_missing_fault=${charger_state_bin_rev:1:1}
if [[ $bat_missing_fault -eq 1 ]]
then
	echo
        echo "The LTC4015 is in battery missing fault state due to no battery detected"
fi
max_charge_time_fault=${charger_state_bin_rev:2:1}
if [[ $max_charge_time_fault -eq 1 ]]
then
	echo
        echo "The LTC4015 is in max charge time fault state due to MAX_CHARGE_TIMER exceeding
        MAX_CHARGE_TIME during a charge cycle (applies to lithium chemistries only)"
fi
c_over_x_term=${charger_state_bin_rev:3:1}
if [[ $c_over_x_term -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 is in C/x termination state due to IBAT dropping below C_OVER_X_THRESHOLD
(applies to lithium chemistries only)."
fi
timer_term=${charger_state_bin_rev:4:1}
if [[ $timer_term -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 is in timer termination state due to battery being at the vcharge voltage for more
than MAX_CV_TIME (applies to lithium chemistries only)."
fi
ntc_pause=${charger_state_bin_rev:5:1}
if [[ $ntc_pause -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 is in thermistor pause state due to NTC_RATIO out of range as set by the JEITA_Tn
values. See the section JEITA Temperature Qualified Charging (applies to lithium chemistries only)."
fi
cc_cv_charge=${charger_state_bin_rev:6:1}
if [[ $cc_cv_charge -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 is in the CC-CV phase of a battery charge cycle."
fi
precharge=${charger_state_bin_rev:7:1}
if [[ $precharge -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 is in the precondition charge phase of a battery charge cycle due to the battery
being below the low battery threshold of 2.9V/cell (applies to Li-Ion chemistries only)."
fi
charger_suspended=${charger_state_bin_rev:8:1}
if [[ $charger_suspended -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 charger is suspended, due to any of the following conditions occurring: (a) the
input voltage on the VIN pin falls below or within 100mV of the BATSENS pin voltage, (b) suspend_charger is writ-
ten to 1 via the serial port, or (c) a system fault condition occurs (VIN overvoltage, 2P5VCC undervoltage, INTVCC
undervoltage, DRVCC undervoltage, thermal shutdown, missing RT resistor, or invalid combination of CELLS pins)."
fi
absorb_charge=${charger_state_bin_rev:9:1}
if [[ $absorb_charge -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 is in the absorb phase of a battery charge cycle (applies to LiFePO 4 and lead-
acid chemistries only)."
fi
equalize_charge=${charger_state_bin_rev:10:1}
if [[ $equalize_charge -eq 1 ]]
then
	echo
		echo "This bit indicates that the LTC4015 is in the equalize phase of a battery charge cycle (applies to lead-acid chemis-
tries only)."
fi

echo
echo "*****************************************************************************************"
#CHARGE_STATUS 0x35
CHARGE_STATUS_hex=$(i2cget 0x34)
CHARGE_STATUS_bin=$(hex2binary $CHARGE_STATUS_hex)
echo CHARGE_STATUS hex = $CHARGE_STATUS_hex bin = $CHARGE_STATUS_bin
CHARGE_STATUS_bin_rev=$(echo $CHARGE_STATUS_bin | rev)

constant_voltage=${CHARGE_STATUS_bin_rev:0:1}
if [[ $bat_short_fault -eq 1 ]]
then
	echo
        echo "This bit indicates that the battery voltage regulation loop of the LTC4015 is in control of the switching charger
current delivery based on VCHARGE_DAC."
fi

constant_current=${CHARGE_STATUS_bin_rev:1:1}
if [[ $bat_short_fault -eq 1 ]]
then
	echo
        echo "This bit indicates that the battery charge current regulation loop of the LTC4015 is in control of the switching
charger current delivery based on ICHARGE_DAC."
fi

iin_limit_active=${CHARGE_STATUS_bin_rev:2:1}
if [[ $bat_short_fault -eq 1 ]]
then
	echo
        echo "This bit indicates that the input current regulation loop of the LTC4015 is in control of the switching charger current
delivery based on IIN_LIMIT_SETTING."
fi

vin_uvcl_active=${CHARGE_STATUS_bin_rev:3:1}
if [[ $bat_short_fault -eq 1 ]]
then
	echo
        echo "This bit indicates that the UVCLFB pin of the undervoltage current limit loop of the LTC4015 is in control of the
switching charger current delivery based on VIN_UVCL_SETTING."
fi

echo
echo "*****************************************************************************************"
#SYSTEM_STATUS 0x35
SYSTEM_STATUS_hex=$(i2cget 0x34)
SYSTEM_STATUS_bin=$(hex2binary $SYSTEM_STATUS_hex)
echo SYSTEM_STATUS hex = $CHARGE_STATUS_hex bin = $CHARGE_STATUS_bin
SYSTEM_STATUS_bin_rev=$(echo $SYSTEM_STATUS_bin | rev)

intvcc_gt2p8v=${CHARGE_STATUS_bin_rev:0:1}
if [[ $intvcc_gt2p8v -eq 1 ]]
then
	echo
        echo "This bit indicates that the INTVCC pin voltage is above the measurement system undervoltage lockout threshold
value of 2.8V (typical)."
fi
intvcc_gt_4p3v=${CHARGE_STATUS_bin_rev:1:1}
if [[ $intvcc_gt_4p3v -eq 1 ]]
then
	echo
        echo "This bit indicates that the INTVCC voltage is above the switching charger undervoltage lockout threshold value of
4.3V (typical)."
fi
vin_gt_vbat=${CHARGE_STATUS_bin_rev:2:1}
if [[ $vin_gt_vbat -eq 1 ]]
then
	echo
        echo "This bit indicates that the VIN pin input voltage is sufficiently above the BATSENS battery voltage to allow charging
operation (typically +200mV)."
fi
vin_ovlo=${CHARGE_STATUS_bin_rev:3:1}
if [[ $vin_ovlo -eq 1 ]]
then
	echo
        echo "This bit indicates that the LTC4015 is in input voltage shutdown protection due to an input voltage above its protec-
tion shutdown threshold of approximately 38.6V (typical)."
fi
thermal_shutdown=${CHARGE_STATUS_bin_rev:4:1}
if [[ $thermal_shutdown -eq 1 ]]
then
	echo
        echo "This bit indicates that the LTC4015 is in thermal shutdown protection due to an excessively high die temperature
(typically 160°C and above)."
fi
no_rt=${CHARGE_STATUS_bin_rev:5:1}
if [[ $no_rt -eq 1 ]]
then
	echo
        echo "This bit indicates that no frequency setting resistor is detected on the RT pin. The RT pin impedance detection circuit
will typically indicate a missing R T resistor for values above 1.4MΩ."
fi
ok_to_charge=${CHARGE_STATUS_bin_rev:6:1}
if [[ $ok_to_charge -eq 1 ]]
then
	echo
        echo "This bit indicates that all system conditions are met to allow battery charging operation."
fi
cell_count_error=${CHARGE_STATUS_bin_rev:8:1}
if [[ $cell_count_error -eq 1 ]]
then
	echo
        echo "This bit indicates that an invalid combination of CELLS pin settings have been detected."
fi
drvcc_good=${CHARGE_STATUS_bin_rev:9:1}
if [[ $drvcc_good -eq 1 ]]
then
	echo
        echo "This bit indicates that the DRVCC pin voltage is above the DRVCC undervoltage lockout level (4.3V typical)."
fi
equalize_req=${CHARGE_STATUS_bin_rev:10:1}
if [[ $equalize_req -eq 1 ]]
then
	echo
        echo "This bit indicates that a rising edge has been detected at the EQ pin and a lead-acid equalization charge is running
or is queued to run. See Lead-Acid Equalization Charge."
fi
mppt_en_pin=${CHARGE_STATUS_bin_rev:11:1}
if [[ $mppt_en_pin -eq 1 ]]
then
	echo
        echo "This bit indicates that the external MPPT pin is detected as being high and maximum power point tracking is enabled."
fi
charger_enabled=${CHARGE_STATUS_bin_rev:13:1}
if [[ $charger_enabled -eq 1 ]]
then
	echo
        echo "This bit indicates that the LTC4015 is actively charging a battery."
fi

echo
echo "*****************************************************************************************"
#VBAT 0x3A
vbatadc_str=$(i2cget 0x3a)
#echo $vbatadc_str
vbatadc=$((vbatadc_str))
vbat=$(echo $vbatadc*0.000192264 | bc -l)
echo VBAT = $vbat V

#*****************************************************************************************
#VIN 0x3B
vinadc_str=$(i2cget 0x3b)
vinadc=$((vinadc_str))
vin=$(echo $vinadc*0.001648 | bc -l)
echo VIN = $vin V

#*****************************************************************************************
#VSYS 0x3C
vsysadc_str=$(i2cget 0x3c)
vsysadc=$((vsysadc_str))
vsys=$(echo $vsysadc*0.001648 | bc -l)
echo VSYS = $vsys V

#*****************************************************************************************
#IBAT 0x3D
ibatadc_str=$(i2cget 0x3d)
#ibatadc=$((ibatadc_str))
ibatadc=$(sign_hex2dec $ibatadc_str)
ibat=$(echo $ibatadc*0.00000146487/$RSNSB | bc -l)
echo IBAT = $ibat A

#*****************************************************************************************
#IIN 0x3E
iinadc_str=$(i2cget 0x3e)
iinadc=$((iinadc_str))
iin=$(echo $iinadc*0.00000146487/$RSNSI | bc -l)
echo IIN = $iin A

echo
echo "*****************************************************************************************"
#CHEM_AND_CELLS 0x43
CHEM_AND_CELL_hex=$(i2cget 0x43)
CHEM_AND_CELL_bin=$(hex2binary $CHEM_AND_CELL_hex)
echo CHEM_AND_CELL hex = $CHEM_AND_CELL_hex bin = $CHEM_AND_CELL_bin
CHEM_AND_CELL_bin_rev=$(echo $CHEM_AND_CELL_bin | rev)

#cells=${CHARGE_STATUS_bin_rev:0:4}
#if [[ $cells -eq 1 ]]
#then
#	echo
#        echo "This bit indicates that the INTVCC pin voltage is above the measurement system undervoltage lockout threshold
#value of 2.8V (typical)."
#fi