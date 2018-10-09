#!/bin/bash

while :
do
echo "********************************************"
echo "*Reload service operation script!          *"
echo "*Please input your operation as these:     *"
echo "*         1. Stop all Modules              *"
echo "*         2. Reload all Modules            *"
echo "*         3. Remove log files 7 days ago   *"
echo "*         0. Exit                          *"
echo "********************************************"

read readchar

echo "Input $readchar." 
case $readchar in
0) exit 0;;

1) echo " Are your sure to stop all?(y/n)"
     read surechar
     echo "you chose $surechar"
     if [ $surechar = y ]
     then

     /sbin/service crond stop
     /usr/bin/pkill  cron
     #mv Module.ini Module.tmp
     /usr/bin/pkill  EServer
     /usr/bin/pkill  RM
     /usr/bin/pkill  XServer
     /usr/bin/pkill  LogMod
     /usr/bin/pkill  InfoServer
     /usr/bin/pkill  WebService
     /usr/bin/pkill  TServer
     /usr/bin/pkill  UDPServer
     echo "Now stoping complete"
     fi
;;
2) #mv Module.tmp Module.ini
#/sbin/service crond start
echo "Now all Modules will restart within 1 minute..."
pkill XServer
pkill RM
pkill EServer
pkill InfoServer
pkill LogMod
pkill WebService
pkill TServer
pkill UDPServer
service crond start
;;
3) ./Remove.sh
#cd /Aretek/TrustLink
#	rm -rf `find * -ctime +30 | grep ".log"` &>/dev/null
#	./Remove.sh
;;
esac
echo
echo
echo
done
	
