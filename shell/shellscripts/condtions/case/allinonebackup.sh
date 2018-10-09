#!/bin/bash
# A shell script to backup mysql, webserver and files to tape
opt=$1
#opt=$( tr '[:upper:]' '[:lower:]' <<<"$1" ) #covert all passed arguments to lowercase using tr command and here strings
shopt -s nocasematch
case $opt in
#Use regex to match all command line arguments         
       # [Ss][Qq][Ll])
	sql)
                echo "Running mysql backup using mysqldump tool..."
                ;;
        #[Ss][Yy][Nn][Cc])
	sync)
                echo "Running backup using rsync tool..."
                ;;
        #[Tt][Aa][Rr])
	tar)
                echo "Running tape backup using tar tool..."
                ;;
        *)
        	    echo "Backup shell script utility"
                echo "Usage: $0 {sql|sync|tar}"
                echo "	sql  : Run mySQL backup utility."
                echo "	sync : Run web server backup utility."	
                echo "	tar  : Run tape backup utility."	;;
esac
shopt -u nocasematch
