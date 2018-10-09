#!/bin/bash
#
#
#
TIME=$(date)

PATH=$PATH:$HOME/bin
export PATH
unset USERNAME

export ORACLE_HOME=/usr/lib/oracle/11.2/client
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:

export LANG="zh_CN.gbk"
export SUPPORTED="zh_CN.GB18030:zh_CN:zh:zh_CN.GB2312:zh_CN:zh:zh_CN.gbk:zh_CN:zh:zh_HK.UTF-8:zh_HK:zh:zh_CN.UTF-8:zh_CN:zh:zh_TW.UTF-8:zh_TW:zh:en_US.UTF-8:en_US:en"
export SYSFONT="latarcyrheb-sun16"
setenforce 0

cat Module.ini | while read line
do
   echo "$line"
   if [ "$line" ]
   then
   if [[ $line == */EServer* ]]
   then
	PROCESS_NUM=`ps ex|grep ' ./EServer '|grep -v grep|grep " PWD=$line"|wc -l`
	echo $PROCESS_NUM
	if [ $PROCESS_NUM -eq 0 ]
	then
	echo `pwd`
	if cd $line
	then
		echo "$TIME Restart $line/EServer">> ../../log/Reload.log
		echo `pwd`
		./EServer &>/dev/null &
	else
		echo `pwd`
		echo "Can't find $line"
	fi
	fi
   
   elif [[ $line == */RM* ]]
   then
	PROCESS_NUM=`ps ex|grep ' ./RM '|grep -v grep|grep " PWD=$line"|wc -l`
	echo $PROCESS_NUM
   	if [ $PROCESS_NUM -eq 0 ]
   	then
        echo `pwd`
        if cd $line
        then
                echo "$TIME Restart $line/RM">> ../../log/Reload.log
                echo `pwd`
                ./RM &>/dev/null &
        else
                echo `pwd`
                echo "Can't find $line"
        fi
   	fi

   elif [[ $line == */XServer* ]]
   then
	PROCESS_NUM=`ps ex|grep './XServer '|grep -v grep|grep " PWD=$line"|wc -l`
	echo $PROCESS_NUM
	if [ $PROCESS_NUM -eq 0 ]
	then
        echo `pwd`
        if cd $line
        then
                echo "$TIME Restart $line/XServer">>../../../log/Reload.log
                echo `pwd`
                ./XServer &>/dev/null &
        else
                echo `pwd`
                echo "Can't find $line"
        fi
	fi
   
   elif [[ $line == */LogMod* ]]
   then
	PROCESS_NUM=`ps ex|grep './LogMod '|grep -v grep|grep " PWD=$line"|wc -l`
	echo $PROCESS_NUM
	if [ $PROCESS_NUM -eq 0 ]
	then
        echo `pwd`
        if cd $line
        then
                echo "$TIME Restart $line/LogMod">> ../../log/Reload.log
                echo `pwd`
                ./LogMod &>/dev/null &
        else
                echo `pwd`
                echo "Can't find $line"
        fi
	fi

#   elif [[ $line == */PICCMod* ]]
#   then
#	PROCESS_NUM=`ps ex|grep './PICCMod '|grep -v grep|grep " PWD=$line"|wc -l`
#	echo $PROCESS_NUM
#	if [ $PROCESS_NUM -eq 0 ]
#	then
#        echo `pwd`
#        if cd $line
#        then
#                echo "$TIME Restart $line/PICCMod">> ../../log/Reload.log
#                echo `pwd`
#                ./PICCMod &>/dev/null &
#        else
#                echo `pwd`
#                echo "Can't find $line"
#        fi
#	fi
	
	# yhg add
elif [[ $line == */InfoServer* ]]
   then
	PROCESS_NUM=`ps ex|grep ' ./InfoServer '|grep -v grep|grep " PWD=$line"|wc -l`
	echo $PROCESS_NUM
   	if [ $PROCESS_NUM -eq 0 ]
   	then
        echo `pwd`
        if cd $line
        then
                echo "$TIME Restart $line/InfoServer">> ../../log/Reload.log
                echo `pwd`
                ./InfoServer &>/dev/null &
        else
                echo `pwd`
                echo "Can't find $line"
        fi
   	fi

elif [[ $line == */WebService* ]]
   then
	PROCESS_NUM=`ps ex|grep ' ./WebService '|grep -v grep|grep " PWD=$line"|wc -l`
	echo $PROCESS_NUM
   	if [ $PROCESS_NUM -eq 0 ]
   	then
        echo `pwd`
        if cd $line
        then
                echo "$TIME Restart $line/WebService">> ../../log/Reload.log
                echo `pwd`
                ./WebService &>/dev/null &
        else
                echo `pwd`
                echo "Can't find $line"
        fi
   	fi
   	
   else
	echo "Can't support Module in $line"

   fi
   fi
done

exit 0
