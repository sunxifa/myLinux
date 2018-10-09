#!/bin/bash
# Recommend syntax for setting an infinite while loop
declare -i n=1
#while :
#while false
while true
do
	echo $((n++))
	echo "Do something; hit [CTRL+C] to stop!"
	sleep 1
done
