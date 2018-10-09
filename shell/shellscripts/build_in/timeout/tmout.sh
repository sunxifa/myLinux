#!/bin/bash

TMOUT=3        #  设置超时的时间为 3 秒 

echo "What is your favorite song?" 
echo "Quickly now, you only have $TMOUT seconds to answer!" 
read song 
if [ -z "$song" ] 
then
	song="(no answer)"
fi

echo "Your favorite song is $song."
