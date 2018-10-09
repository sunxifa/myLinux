#!/bin/bash
#The declare command is used to create the constant variable called PASSWD_FILE.
# The function die() is defined before all other functions.
# You can call a function from the same script or other function. For example, die() is called from is_user_exist().
# All function variables are local. This is a good programming practice. 
# Make readonly variable i.e. constant variable
declare -r PASSWD_FILE=/etc/passwd
 
#
# Purpose: Display message and die with given exit code
# 
die(){
        local message="$1"
        local exitCode=$2
        echo "$message"
        [ "$exitCode" == "" ] && exit 1 || exit $exitCode
}
 
#
# Purpose: Find out if user exits or not
#
does_user_exist(){
        local u=$1
        grep -qEw "^$u" $PASSWD_FILE && die "Username $u exists."
}
 
#
# Purpose: Is script run by root? Else die..
# 
is_user_root(){
  [ "$(id -u)" != "0" ] && die "You must be root to run this script" 2
}
 
#
# Purpose: Display usage
# 
usage(){
	echo "Usage: $0 username"
	exit 2
}
 
 
[ $# -eq 0 ] && usage
 
# invoke the function is_root_user
is_user_root
 
# call the function is_user_exist
does_user_exist "$1"
 
# display something on screen
echo "Adding user $1 to database..."
# just display command but do not add a user to system
echo "/sbin/useradd -s /sbin/bash -m $1"
