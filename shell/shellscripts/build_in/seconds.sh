#!/bin/bash

TIME_LIMIT=10
INTERVAL=1

echo
echo "Hit Control-C to exit before $TIME_LIMIT seconds."
echo

while [ "$SECONDS" -le "$TIME_LIMIT" ]
do
	if [ "$SECONDS" -eq 1 ]
	then
	units=second
	else
	units=seconds
	fi
	echo "This script has been running $SECONDS $units."
#    在一台比较慢的或者是负载很大的机器上,这个脚本可能会跳过几次循环 
#+  在一个 while 循环中. 
	sleep $INTERVAL
done

echo -e "\a" #Beep!

exit 0
