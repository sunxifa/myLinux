#!/bin/bash  
#tomcat restart script

#set language environment
LANG=C
#set tomcat_base & log path
tomcat_base=/usr/sdses/apache-tomcat-5.5.23lsnew
log_path=/var/log/tomcat_restart

#first, empty the tomcat restart log file every month
d=`date +%d`
if [ $d -eq 01 ]
then
{
  >$log_path
}
fi
pid=`ps aux | grep tomcat | grep -v grep|grep -v tomcat_restart  | awk '{print $2}'`  
echo --------------------------------------------------- >>$log_path
echo The old Tomcat PID is:$pid   >>$log_path
  
#then, here comes the big thing,restart  tomcat
if [ -n "$pid" ]  
then  
{  
   echo $(date +%F-%R) shutdown >>$log_path
   ${tomcat_base}/bin/shutdown.sh  &>>$log_path
   sleep 5  
   pid=`ps aux | grep tomcat | grep -v grep  |grep -v tomcat_restart  | awk '{print $2}'`  
   if [ -n "$pid" ]  
   then  
    {  
      sleep 1   
      echo $(date +%F-%R) kill tomcat   >>$log_path 
      kill -9 $pid &>>$log_path 
    }  
   fi  
   sleep 5  
#remove log files 30 days ago
   echo $(date +%F-%R) remove log files >>$log_path
   find ${tomcat_base}/logs -mtime +30  -exec rm -f {} \; &>>$log_path
   sleep 1
   echo $(date +%F-%R) startup.sh >>$log_path 
	   ${tomcat_base}/bin/startup.sh  &>>$log_path
 }  
else  
#remove log files 30 days ago
 echo $(date +%F-%R) removelog >>$log_path
find ${tomcat_base}/logs -mtime +30  -exec rm -f {} \; &>>$log_path

echo $(date +%F-%R) direct startup.sh  >>$log_path
${tomcat_base}/bin/startup.sh  &>>$log_path
  
fi  

#startup end
echo $(date +%F-%R) startup end >>$log_path
pid=`ps aux | grep tomcat | grep -v grep  |grep -v tomcat_restart  | awk '{print $2}'`
echo The new  Tomcat PID is:$pid >>$log_path
