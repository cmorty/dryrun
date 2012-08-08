#!/bin/bash


makro_num ()
{
	name=$1
	start=$2
	end=$3
	rv=()
	if [ -z $4 ] ; then
		step=1
	else 
		step=$4
	fi	
	for num in {${start}..${end}..${step}} ; do
		rv[${#rv[*]}]= " -D${name}=${num} "
	done
	return rv
}


merge()
{
	rv=($1 $2)
}
