#!/bin/bash

#For excuting the scripts every 3 seconds in crond.
#20110111.WXG
#cd /Aratek/TrustLink/log/
#File=`date +%Y%m%d`
#echo "$File">/tmp/Remove.log
#echo `date`

#Restart Time just like hour(00~23):minute(00~59)
ReTime=00:00

cd  /
Line=`ps ax|grep cron_seconds.sh|grep -v grep|grep /dev`
TMP=$(echo "$Line"|awk '{print $7}')
echo "$TMP"|awk -F/ '{for(x=2;x<NF;x++)print $x}'>/tmp/tmp.txt
echo "luojun">>/tmp/tmp.txt
cat /tmp/tmp.txt
cat /tmp/tmp.txt|while read line
do
#       echo $line
  if [ "$line" == "luojun" ]
  then
        echo "NowPWD$PWD"
	
	for((i=0;i<20;i++));do
 #      echo `pwd`>>/Aratek/TrustLink/cron.log
        	./CheckProcess.sh 2>/dev/null &
        	sleep 3
	done
	sleep 2
	File=`date +%H:%M`
#	line=`cat Remove.log`
	if [ "$ReTime" == "$File" ]
	then
        	echo 1
	
       		./Remove.sh
		/usr/bin/pkill  EServer
        	/usr/bin/pkill  RM
        	/usr/bin/pkill  XServer
        #	/usr/bin/pkill  PICCMod
        	/usr/bin/pkill  LogMod
        	/usr/bin/pkill  InfoServer
        	/usr/bin/pkill  WebService
	else
		
        	#cd /Aratek/TrustLink

#       echo "$File">Remove.log
        	echo 0
	fi

 	 else
        	cd "$line"
        PWD=`pwd`
  fi
done
rm -rf /tmp/tmp.txt
echo "$PWD"
exit 0

#for((i=0;i<20;i++));do
 #     	echo `pwd`>>/Aratek/TrustLink/cron.log
#	exec ./CheckProcess.sh 2>/dev/null &
#        sleep 3
#done

cd /Aratek/TrustLink/log/
line=`cat Remove.log`
if [ $line = $File ]
then
        echo 1
else
	cd /Aratek/TrustLink
        ./Remove.sh
	/usr/bin/pkill  EServer
        /usr/bin/pkill  RM
        /usr/bin/pkill  XServer
        #/usr/bin/pkill  PICCMod
        /usr/bin/pkill  LogMod
        /usr/bin/pkill  InfoServer
        /usr/bin/pkill  WebService

#       echo "$File">Remove.log
        echo 0
fi
echo

exit 0
