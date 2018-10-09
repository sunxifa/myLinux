#!/bin/bash
echo "***************************************************"
echo "*                                                 *"
echo "*        Welcome to use TrustLink v5.3.1.1125     *"
echo "*                                                 *"
echo "***************************************************"
#echo ""
#../SQLClient/SQLClient SQLITE test test test tl53_SQLITE.sql
echo "+---------------------------------------------------+"
echo "| Please input the home directory: [Default is '/'] |"
echo "+---------------------------------------------------+"
read HomePwd
if [[ "$HomePwd" == */ ]]
then
	Home="$HomePwd"
	echo "Accepted: [$Home]"
else
	Home="$HomePwd/"
	echo "Accepted: [$Home]"
fi
`chmod +x *`
NowPwd=`pwd`
cd "$Home"Aratek/TrustLink 2>/dev/null
MYPWD=`pwd`
#echo "$MYPWD"

if [ "$MYPWD" == "$Home"Aratek/TrustLink ]
then
	echo "+----------------------------------------------------------------------------+"
	echo "| Find old TrustLink! Would you like to overwrite it? [Default is 'y'] (y/n) |"
	echo "+----------------------------------------------------------------------------+"
	read Input
	if [ "$Input" ]
	then
		if [ "$Input" == "Y" -o "$Input" == "y" ]
		then
			echo "Accepted: [y]"
			service crond stop > /dev/nul
                        pkill cron
                        pkill XServer
                        pkill RM
                        pkill EServer
                        pkill InfoServer
                        pkill LogMod
                        pkill WebService
			pkill TServer
			`rm -rf "$Home"Aratek/TrustLink/*`
		else
			echo "Accpted: [n]"
			echo "Exit now!"
			exit 0
		fi
	else
		echo "Accpeted: [y]"
		service crond stop > /dev/nul
                pkill cron
                pkill XServer
                pkill RM
                pkill EServer
                pkill InfoServer
                pkill LogMod
                pkill WebService
		pkill TServer
		`rm -rf "$Home"Aratek/TrustLink/*`
	fi
else
	echo "Create New Dir"
	`mkdir -p "$Home"Aratek/TrustLink`
fi
cd "$NowPwd"
`cp -rf  ../../*   "$Home"Aratek/TrustLink/`
#exit 0
cd "$Home"Aratek/TrustLink
`cp lib/*.so* /usr/lib`

# echo "+------------------------------------------------+"
# echo "| Dual hot standby mode ? [Default is 'n'] (y/n) |"
# echo "+------------------------------------------------+"
gMainMacIP=127.0.0.1
gBackupMacIP=127.0.0.2
# read IsTwoMachine
IsTwoMachine="n"
#if [[ $IsTwoMachine == "y" ]]
if [ "$IsTwoMachine" == "Y" -o "$IsTwoMachine" == "y" ]
then
   echo "Please Input Main Machine IP..."
   read MainMachineIP
   echo $MainMachineIP
   gMainMacIP=$MainMachineIP
   echo "Please Input Backup Machine IP..."
   read BackupMachine
   echo $BackupMachine
   gBackupMacIP=$BackupMachine
#else
#   echo "Accepted: [n]"
fi

cd "$Home"Aratek/TrustLink/bin/EServer/
#echo "Setting EServer config!"
echo "[System]">EServer.ini
echo "+---------------------------------------------+"
echo "| Please input the port! [Default port 26058] |"
echo "+---------------------------------------------+"
read DE_PORT
if [ "$DE_PORT" ]
then
	echo "Accepted: [$DE_PORT]"
else
	DE_PORT=26058
	echo "Accepted: [26058]"
fi	
echo Port="$DE_PORT" >>EServer.ini

echo "[Log]" >> EServer.ini
echo Path="$Home"Aratek/TrustLink/log/EServer/ >>EServer.ini
echo "Level=2" >> EServer.ini
echo "LogToScreen=0" >> EServer.ini

cd "$Home"Aratek/TrustLink/bin/RM/
#echo "create RM.ini and LogMod.ini!"
echo "[EServer]" > RM.ini
#echo "Please input EServer_ip!"
#read DE_IP
DE_IP=127.0.0.1
DE_IP2=127.0.0.2
#if [[ $IsTwoMachine = "y" ]]
if [ "$IsTwoMachine" == "Y" -o "$IsTwoMachine" == "y" ]
then
	  DE_IP=$gMainMacIP
	  DE_IP2=$gBackupMacIP	          
fi

echo IP1="$DE_IP" >> RM.ini
echo Port1="$DE_PORT" >> RM.ini
echo IP2="$DE_IP2" >> RM.ini
echo Port2="$DE_PORT" >>RM.ini
RM_ID=RM_127
echo ModName="$RM_ID" >>RM.ini
echo "InstanceID=0" >>RM.ini

echo "[System]" >> RM.ini
echo "ModIsMaster=1" >> RM.ini
echo "EncryptKey=aratek1234" >> RM.ini

echo "[Log]" >> RM.ini
echo Path="$Home"Aratek/TrustLink/log/RM/ >>RM.ini
echo "Level=3" >> RM.ini
echo "LogToScreen=1" >> RM.ini

#echo "Setting DB config"
echo "[Database]" >> RM.ini
echo "+---------------------------+"
echo "| Supported Database types: |"
echo "|                           |"
echo "|       1 - Oracle          |"
echo "|       2 - Mysql           |"
echo "|       3 - SQLServer       |"
echo "|       4 - DB2             |"
echo "|       5 - Sybase          |"
echo "|       6 - SQLITE          |"
echo "|                           |"
echo "| Please input ('1'~'6'):   |"
echo "+---------------------------+"
read DBTypeNum
DBType="None"
if [ "$DBTypeNum" = "1" ]; then
  DBType="Oracle"
fi
if [ "$DBTypeNum" = "2" ]; then
  DBType="Mysql"
fi
if [ "$DBTypeNum" = "3" ]; then
  DBType="SQLServer"
fi
if [ "$DBTypeNum" = "4" ]; then
  DBType="DB2"
fi
if [ "$DBTypeNum" = "5" ]; then
  DBType="Sybase"
fi
if [ "$DBTypeNum" = "6" ]; then
  DBType="SQLITE"
fi
echo "Accepted: [$DBType]"

#if [ "$DBType" = "Sybase" ]; then
#  DBType="SQLServer"
#fi
echo Type="$DBType" >> RM.ini

if [ "$DBType" != "SQLITE" ]; then
	echo "+-----------------------+"
	echo "| Please input ODBC DSN |"
	echo "+-----------------------+"
	read DSN
	echo Name="$DSN" >>RM.ini
	echo "+-----------------------+"
	echo "| Please input USERNAME |"
	echo "+-----------------------+"
	read USERNAME
	echo User="$USERNAME" >> RM.ini
	echo "+-----------------------+"
	echo "| Please input PASSWORD |"
	echo "+-----------------------+"
	read PASSWORD
	echo Password="$PASSWORD" >> RM.ini
else
        DSN="sqlite"
        echo Name="$DSN" >>RM.ini
        USERNAME="sqlite"
        echo User="$USERNAME" >> RM.ini
        PASSWORD="sqlite"
        echo Password="$PASSWORD" >> RM.ini
fi
echo "TempTabName=NTL_ENROLL" >> RM.ini
echo "IndexTabName=NTL_TEMPINDEX" >> RM.ini


cd "$Home"Aratek/TrustLink/bin/LogMod/
echo "[Database]" > LogMod.ini
echo Type="$DBType" >>LogMod.ini
echo Name="$DSN" >>LogMod.ini
echo User="$USERNAME" >>LogMod.ini
echo Password="$PASSWORD" >>LogMod.ini
#  
echo "FINLOGTableName =NTL_FINGER_LOG" >>LogMod.ini
echo "TIFLOGTableName = TIF_OPT_LOG" >>LogMod.ini
echo "USERLOCKTableName = NTL_USERLOCK_LOG" >>LogMod.ini
echo "SYSSETTableName = NTL_SYS_SET" >>LogMod.ini
echo "TrsRLogTableName = TIF_TRSRIGHT_LOG" >>LogMod.ini
# 
#TFMLOGTableName = TFM_OPT_LOG
# 
echo "DB_Keepalive_Period = 30" >>LogMod.ini

echo "[EServer]" >> LogMod.ini
echo IP1="$DE_IP" >>LogMod.ini
echo Port1="$DE_PORT" >>LogMod.ini
echo IP2="$DE_IP2" >>LogMod.ini
echo Port2="$DE_PORT" >>LogMod.ini
echo "ModName = LogMod" >>LogMod.ini
echo "InstanceID =0" >>LogMod.ini

echo "[Server]" >> LogMod.ini
echo "BRANCH_NO    = aaa" >> LogMod.ini
echo "TOLERANT     = 0" >> LogMod.ini
echo "LogModNumb =0" >> LogMod.ini
echo "LOGIDLEN     = 11" >> LogMod.ini
echo "SleepTime = 5" >> LogMod.ini
echo "ThreadNum = 3" >> LogMod.ini
echo "FingerLog = true" >> LogMod.ini
#CallSprocs = false

echo "[Log]" >> LogMod.ini
echo Path="$Home"Aratek/TrustLink/log/LogMod/ >>LogMod.ini
echo "Level=2" >> LogMod.ini
echo "LogToScreen=1" >> LogMod.ini


#cd "$Home"Aratek/TrustLink/bin/PICCMod/
#echo "[DE]">PICCMod.ini
#echo "IP1=$DE_IP">>PICCMod.ini
#echo "Port1=$DE_PORT">>PICCMod.ini
#echo "IP2=$DE_IP">>PICCMod.ini
#echo "Port2=$DE_PORT">>PICCMod.ini
#echo "[Server]">>PICCMod.ini
#echo "RM_ID = $RM_ID">>PICCMod.ini
#echo "Version = 1">>PICCMod.ini

#echo "[LOG]">>PICCMod.ini
#echo Path="$Home"Aratek/TrustLink/log/PICCMod/ >>PICCMod.ini
#echo "LEVEL=3">>PICCMod.ini

#echo "How many XServer do you need in RM?(Max is 10)"
#read INPUT
#if [ "$INPUT" -ge 10 ]
#then
#	INPUT=10
#fi

#if [ "$INPUT" -le 1 ]
#then
#	INPUT=1
#fi

#echo "Setting XServer config!"
echo "Please wait a moment..."
#cd /Aratek/TrustLink/RM1/XServer1
#`sed -i "1,5s/Name.*/Name=$DSN/" XServer.ini`
#`sed -i "s/User.*/User=$USERNAME/" XServer.ini`
#`sed -i "s/Password.*/Password=$PASSWORD/" XServer.ini`
#`sed -i "s/IP1.*/IP1=$DE_IP/" XServer.ini`
#`sed -i "s/Port1.*/Port1=$DE_PORT/" XServer.ini`
#`sed -i "s/IP2.*/IP2=$DE_IP/" XServer.ini`
#`sed -i "s/Port2.*/Port2=$DE_PORT/" XServer.ini`
#echo "Please input xserver1 name!"
#read SRVNAME
#`sed -i "5,20s/Name.*/Name=$XSrv1/" XServer.ini`
#`sed -i "s/RM_ID.*/RM_ID=$RM_ID/" XServer.ini`

INPUT=1
if [[ $IsTwoMachine = "y" ]]
then 
    INPUT=2
fi

for((i=1;i<="$INPUT";i++));do
#	cd /Aratek/TrustLink
#	`cp RM1/XServer1 RM1/XServer"$i" -rf 2>/dev/null`
	cd "$Home"Aratek/TrustLink/bin/XServer/"$i"
#	LOGPWD="$Home"Aratek/TrustLink/LOG/RM1/XServer"$i"
#	echo "$LOGPWD"
#	`sed -i "1,5s/Name.*/Name=$DSN/" XServer.ini`
#	`sed -i "s/User.*/User=$USERNAME/" XServer.ini`
#	`sed -i "s/Password.*/Password=$PASSWORD/" XServer.ini`
#	`sed -i "s/IP1.*/IP1=$DE_IP/" XServer.ini`
#	`sed -i "s/Port1.*/Port1=$DE_PORT/" XServer.ini`
#	`sed -i "s/IP2.*/IP2=$DE_IP/" XServer.ini`
#	`sed -i "s/Port2.*/Port2=$DE_PORT/" XServer.ini`
#	echo "Please input xserver$i name!"
#	read SRVNAME
	echo "[EServer]" >XServer.ini
	echo IP1="$DE_IP" >>XServer.ini
	echo Port1="$DE_PORT" >>XServer.ini
	echo IP2="$DE_IP2" >>XServer.ini
	echo Port2="$DE_PORT" >>XServer.ini
	echo ModName=XSrv"$i" >>XServer.ini
	echo "InstanceID=0" >>XServer.ini
	
	echo "[RM]" >>XServer.ini
#	echo RM_ID="$RM_ID" >>XServer.ini
#	echo ModName=XSrv"$i" >>XServer.ini
	echo ModName="$RM_ID" >>XServer.ini
	echo "Force=True"  >>XServer.ini
	echo "InstanceID=0" >>XServer.ini
	
	echo "[System]" >>XServer.ini
	echo "VerifyMethod=0" >>XServer.ini
	echo "CheckFeature=1" >>XServer.ini
	
	echo "[Log]" >>XServer.ini
	echo Path="$Home"Aratek/TrustLink/log/XServer/"$i"/ >>XServer.ini
	echo "Level=3" >>XServer.ini
	echo "LogToScreen=1" >>XServer.ini
#	`sed -i "s/Path.*/Path=$LOGPWD/" XServer.ini`
#	`sed -i "s/IP1.*/IP1=$DE_IP/" XServer.ini`
#	`sed -i "s/Port1.*/Port1=$DE_PORT/" XServer.ini`
#	`sed -i "s/IP2.*/IP2=$DE_IP/" XServer.ini`
#	`sed -i "s/Port2.*/Port2=$DE_PORT/" XServer.ini`
#	`sed -i "5,20s/Name.*/Name=XSrv$i/" XServer.ini`
#	`sed -i "s/RM_ID.*/RM_ID=$RM_ID/" XServer.ini`
#	`sed -i "s/XServer1/XServer$i/" XServer.ini`
done
#echo "XServer config set complete!"

#echo "Start Setting InfoServer config!"
cd "$Home"Aratek/TrustLink/bin/InfoServer/
echo "[Database]" > InfoServer.ini
echo Type="$DBType" >>InfoServer.ini
echo Name="$DSN" >>InfoServer.ini
echo User="$USERNAME" >>InfoServer.ini
echo Password="$PASSWORD" >>InfoServer.ini
echo "DevTableName = TIF_DEVICE" >>InfoServer.ini
echo "DatTableName = TIF_APP_INFODATA" >>InfoServer.ini
echo "SysTableName = NTL_SYS_SET" >>InfoServer.ini
echo "EnrolltableName = NTL_ENROLL" >>InfoServer.ini
#echo "TrsTableName = TIF_TRSRIGHT" >>InfoServer.ini
#echo "TrsDTableName = TIF_TRSRIGHT_DETAIL" >>InfoServer.ini
#echo "AccTableName = TIF_APP_DETAIL" >>InfoServer.ini
#echo "UserTableName = TIF_USER" >>InfoServer.ini
#echo "AppHtableName = TIF_APP_HEAD" >>InfoServer.ini
#echo "OptCtableName = TIF_OPT_CONTROL" >>InfoServer.ini
#echo "AGRightTableName = TIF_APP_GROUP_RIGHT" >>InfoServer.ini
#echo "AGroupTableName = TIF_APP_GROUP" >>InfoServer.ini
echo "DB_Keepalive_Period = 30" >>InfoServer.ini

echo "[EServer]" >> InfoServer.ini
echo IP1="$DE_IP" >>InfoServer.ini
echo Port1="$DE_PORT" >>InfoServer.ini
echo IP2="$DE_IP2" >>InfoServer.ini
echo Port2="$DE_PORT" >>InfoServer.ini
echo "ModName =Info" >>InfoServer.ini
echo "InstanceID =0" >>InfoServer.ini

echo "[Server]" >>InfoServer.ini
echo RM_ID="$RM_ID"  >>InfoServer.ini
echo "Version   = 0" >>InfoServer.ini
echo "SleepTime = 3" >>InfoServer.ini
echo "ThreadNum = 3" >>InfoServer.ini
echo "UpdateMemTableTime = 60" >>InfoServer.ini

echo "[Log]" >> InfoServer.ini
# 
echo Path="$Home"Aratek/TrustLink/log/InfoServer/ >>InfoServer.ini
echo "Level=3" >> InfoServer.ini
echo "LogToScreen=1" >> InfoServer.ini
#echo "End Setting InfoServer config!"

#echo "config WebService!"
cd "$Home"Aratek/TrustLink/bin/WebService/
#echo "start config WebService.ini"
echo "[Http]" >WebService.ini
echo "HttpPort = 26059" >>WebService.ini
echo "Backlog = 30" >>WebService.ini

echo "[Thread]" >>WebService.ini
echo "ThreadNumber = 10" >>WebService.ini

echo "[Log]" >>WebService.ini
echo Path="$Home"Aratek/TrustLink/log/WebService/ >>WebService.ini
echo "Level =2" >>WebService.ini
echo "LogToScreen = 1" >>WebService.ini

#echo "config XInterface.ini"
echo "[SourceModule]" >XInterface.ini
echo "WaitTime = 30" >>XInterface.ini
echo "FpImportMode = 0" >>XInterface.ini

echo "[EServer]" >>XInterface.ini
echo IP1 ="$DE_IP"  >>XInterface.ini
echo Port1 ="$DE_PORT" >>XInterface.ini
echo IP2 ="$DE_IP2" >>XInterface.ini
echo Port2 ="$DE_PORT" >>XInterface.ini
echo "ModName = XIf" >>XInterface.ini
echo "InstanceID =0" >>XInterface.ini

echo "[RmServer]" >>XInterface.ini
echo "ModName =RM_127" >>XInterface.ini

echo "[LogServer]" >>XInterface.ini
echo "ModName = LogMod" >>XInterface.ini

echo "[InfoServer]" >>XInterface.ini
echo "Enable = true" >>XInterface.ini
echo "ModName = Info" >>XInterface.ini

echo "[Validate]" >>XInterface.ini
echo "ValidateIsv = false" >>XInterface.ini

echo "[Log]" >>XInterface.ini
echo Path="$Home"Aratek/TrustLink/log/WebService/XInterface >>XInterface.ini
echo "Level =3" >>XInterface.ini
echo "LogToScreen = 1" >>XInterface.ini

#echo "config TServer"
cd "$Home"Aratek/TrustLink/bin/TServer/
echo "[EServer]" >TServer.ini
echo IP1 ="$DE_IP" >>TServer.ini
echo Port1 = "$DE_PORT" >>TServer.ini
echo IP2 = "$DE_IP2" >>TServer.ini
echo Port2 = "$DE_PORT" >>TServer.ini
echo "ModName = TServer" >>TServer.ini
echo "InstanceID = 0" >>TServer.ini

echo "[Server]" >>TServer.ini
echo "SleepTime = 3" >>TServer.ini
echo "ThreadNum = 3" >>TServer.ini
echo "UpdateMemTableTime = 3600" >>TServer.ini

echo "[Log]" >>TServer.ini
echo Path = "$Home"Aratek/TrustLink/log/TServer/ >>TServer.ini
echo "Level = 3" >>TServer.ini
echo "LogToScreen = 1" >>TServer.ini

#echo "config UDPServer"
cd "$Home"Aratek/TrustLink/bin/UDPServer/
echo "[System]" >UDPServer.ini
echo "UDPPort = 26059" >>UDPServer.ini

echo "[EServer]" >>UDPServer.ini
echo IP1 = "$DE_IP" >>UDPServer.ini
echo Port1 = "$DE_PORT" >>UDPServer.ini
echo IP2 = "$DE_IP2" >>UDPServer.ini
echo Port2 = "$DE_PORT" >>UDPServer.ini
echo "ModNmae = UDPSrv" >>UDPServer.ini
echo "InstanceID = 0" >>UDPServer.ini

echo "[Log]" >>UDPServer.ini
echo "Path = ./log" >>UDPServer.ini
echo "Level = 3" >>UDPServer.ini
echo "LogToScreen = 1" >>UDPServer.ini

echo "[Threshold]" >>UDPServer.ini
echo "MatchSpeed = 80" >>UDPServer.ini
echo "MaximalRotation = 45" >>UDPServer.ini
echo "MatchThreshold = 0" >>UDPServer.ini
echo "XYThreshold = 11" >>UDPServer.ini
echo "AngleThreshold = 11" >>UDPServer.ini
echo "CThreshold = 5" >>UDPServer.ini
echo "VMatchSpeed = 40" >>UDPServer.ini
echo "VMaximalRotation = 180" >>UDPServer.ini
echo "VMatchThreshold = 60" >>UDPServer.ini

echo "[RM]" >>UDPServer.ini
echo "ModName = RM_127" >>UDPServer.ini
echo "Force = False" >>UDPServer.ini
echo "InstanceID = 0" >>UDPServer.ini

cd "$Home"Aratek/TrustLink/bin/Script
#echo "Now update Module.ini"
echo "$Home""Aratek/TrustLink/bin/EServer" >Module.ini
echo "$Home""Aratek/TrustLink/bin/RM" >>Module.ini
echo "$Home""Aratek/TrustLink/bin/XServer/1" >>Module.ini
if [[ $IsTwoMachine = "y" ]]
then 
	echo "$Home""Aratek/TrustLink/bin/XServer/2" >>Module.ini
fi
echo "$Home""Aratek/TrustLink/bin/LogMod" >>Module.ini
echo "$Home""Aratek/TrustLink/bin/InfoServer" >>Module.ini
echo "$Home""Aratek/TrustLink/bin/WebService" >>Module.ini
echo "$Home""Aratek/TrustLink/bin/TServer" >>Module.ini
echo "$Home""Aratek/TrustLink/bin/UDPServer" >>Module.ini

#LDNO=`set|grep LD_LIBRARY_PATH|wc -l`
#if [ $LDNO -eq 0 ]
#then
#	echo "NO LD_LIBRARY_PATH!"
#	echo "Can't autostart TrustLink!"
#	`mv Module.ini Module.tmp`
##	exit 0
#fi

WHO=`whoami`
CRO=`cat /var/spool/cron/"$WHO"|grep "$Home"Aratek/TrustLink/bin/Script/cron_seconds.sh|wc -l`
if [ $CRO -eq 0 ]
then
	echo "* * * * * $Home""Aratek/TrustLink/bin/Script/cron_seconds.sh > /dev/null 2>&1">> /var/spool/cron/root
fi

# 需要先设置好unixODBC所在路径，才能正确执行SQLClient
echo "+----------------------------------------------+"
echo "| Where is unixODBC path? [Default /usr/local] |"
echo "+----------------------------------------------+"
read ODBCHOME
if [ "$ODBCHOME" ]
then
	ODBCHOME="$ODBCHOME/lib"
else
	ODBCHOME="/usr/local/lib"
fi
echo "Accepted: [$ODBCHOME]"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$ODBCHOME"
#echo $LD_LIBRARY_PATH

cd "$Home"Aratek/TrustLink/bin/Script
echo "******** Creating Tables ********"
# "Support DB Type: Oracle,Mysql,SQLServer,DB2,SQLITE,Sybase"
DBOK="0"
DBInitFile="InsertTable.sql"
if [ "$DBType" = "Oracle" ]; then
  DBOK="1"
  #echo "exc tl53_Oracle.sql"
  export NLS_LANG="SIMPLIFIED CHINESE_CHINA.ZHS16GBK"
  sed -i '1i export NLS_LANG="SIMPLIFIED CHINESE_CHINA.ZHS16GBK"' ~/.bash_profile 
  #isql $DSN $USERNAME $PASSWORD -w < tl53_Oracle.sql > /dev/nul
  ../SQLClient/SQLClient Oracle $DSN $USERNAME $PASSWORD tl53_Oracle.sql
fi

if [ "$DBType" = "Mysql" ]; then
  DBOK="1"
  #echo "exc tl53_Mysql.sql"
  isql $DSN $USERNAME $PASSWORD -w < tl53_Mysql.sql >dberr.log 
  DBInitFile="InsertTable_Mysql.sql"
  cat InsertTable_Header_Mysql.sql InsertTable.sql > InsertTable_Mysql.sql
fi

if [ "$DBType" = "DB2" ]; then
  DBOK="1"
  #echo "exc tl53_DB2.sql"
  #isql $DSN $USERNAME $PASSWORD -w < tl53_DB2.sql  >dberr.log
  ../SQLClient/SQLClient DB2 $DSN $USERNAME $PASSWORD tl53_DB2.sql
fi

if [ "$DBType" = "SQLServer" ]; then
  DBOK="1"
  #echo "exc tl53_SQLServer.sql"
  #isql $DSN $USERNAME $PASSWORD -w < tl53_SQLServer.sql  >dberr.log
  ../SQLClient/SQLClient $DBType $DSN $USERNAME $PASSWORD tl53_SQLServer.sql
fi

if [ "$DBType" = "Sybase" ]; then
  DBOK="1"
  #echo "exc tl53_Sybase.sql"
  #isql $DSN $USERNAME $PASSWORD -w < tl53_SQLServer.sql  >dberr.log
  DBInitFile="InsertTable_sybase.sql"
  ../SQLClient/SQLClient $DBType $DSN $USERNAME $PASSWORD tl53_Sybase.sql
fi

if [ "$DBType" = "SQLITE" ]; then
  DBOK="1"
  #echo "exc tl53_SQLITE.sql"
  ../SQLClient/SQLClient SQLITE $DSN test test tl53_SQLITE.sql
fi

if [ "$DBOK" = "0" ]; then
  echo "Mistake user inpurt db type, DBType = $DBType"
  echo "no select db..."
  exit 1
fi

echo "******** Creating Init Records ********"
#echo "exc $DBInitFile"
#isql $DSN $USERNAME $PASSWORD -w < $DBInitFile >>dberr.log
../SQLClient/SQLClient $DBType $DSN $USERNAME $PASSWORD $DBInitFile

echo "******** Creating XServer Records ********"

if [ "$DBType" != "Sybase" ]; then
../SQLClient/SQLClient $DBType $DSN $USERNAME $PASSWORD initdb.sql 
else
../SQLClient/SQLClient $DBType $DSN $USERNAME $PASSWORD initdb_sybase.sql 
fi

LDNO=`set|grep LD_LIBRARY_PATH|wc -l`
if [ $LDNO -eq 0 ]
then
	echo "NO LD_LIBRARY_PATH!"
	echo "Can't autostart TrustLink!"
	`mv Module.ini Module.tmp`
fi
service crond start > /dev/nul
echo "+---------------------------------------------------+"
echo "|             TrustLink install completed!          |"
echo "|      ### We recommend reboot this system! ###     |"
echo "+---------------------------------------------------+"
ENFORCE=`getenforce`
#echo Enforced = $ENFORCE
if [ "$ENFORCE" != "Disabled" ]; then
	echo "*****************************************************"
	echo "*                                                   *"
	echo "*      Warning, Please modify SELINUX=Disabled.     *"
	echo "*                                                   *"
	echo "*****************************************************"
  setenforce 0 > /dev/nul
fi
if [ "$DBType" = "Oracle" ]; then
  echo "### Please update your ORACLE_HOME in 'Aratek\TrustLink\bin\Script\CheckProcess.sh' ###"
fi
exit 0
