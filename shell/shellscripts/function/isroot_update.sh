#!/bin/bash
# version 2.0
#In computer a shell function name can take an input, $1 and return back the value (true or false) to the script.
#In other words, you can return from a function with an exit status. 
#The return command causes a function to exit with the return value specified by N and syntax is:
#return N
#If N is not specified, the return status is that of the last command.
#The return command terminates the function.
#The return command is not necessary when the return value is that of the last command executed
# define constants 
declare -r TRUE=0
declare -r FALSE=1
 
# Purpose: Determine if current user is root or not
is_root_user(){
 # root user has user id (UID) zero.
 [ $(id -u) -eq 0 ] && return $true || return $FALSE
}
 
is_root_user && echo "You can run this script." || echo "You need to run this script as a root user."
