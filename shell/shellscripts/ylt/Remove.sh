#!/bin/bash
#remove .log file 30 days ago

cd  ../../
 rm  -rf `find * -ctime +7 | grep ".log"` &>/dev/null

#`find "$DIR"* -ctime +30`
#echo `find "$line"* -ctime +30 | grep ".log"`
#	then rm -rf `find * -ctime +30 | grep ".log"` &>/dev/null

#done
exit 0
