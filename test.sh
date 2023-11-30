#! /bin/bash

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