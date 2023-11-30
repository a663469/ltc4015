#! /bin/bash

# echo "i2c dump reader"

input="conv_dump_ltc4015.txt"

if [ $# -eq 0 ]
then
	echo "Argument(s) not supplied "
	echo "Usage: hex2binary"
else
	while read -r line
	do
		if [[ $line =~ $1 ]]
		then
			# echo $line
			arr=($line)
			echo ${arr[1]}
		fi
	done < "$input"
fi
# i=0
# j=0

# declare -A i2cmap

# while read -r line
# do
# 	if [[ $i -eq 0 ]]
# 	then
# 		if [[ $line != *"0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f"* ]]
# 		then
# 			echo Error file $input
# 			exit 1
# 		fi
# 	else
# 		{
# 			k=2
# 			while [[ $k -le 9 ]]
# 			do
# 				printf "%s" $line | cut -d " " -f $k
# 				k=$((k+1))
# 			done
# 		}
# 	fi

# 	i=$((i+1))
# 	# #echo $i
# 	# hex=$(printf '%x' $i)
# 	# echo $hex

# done < "$input"