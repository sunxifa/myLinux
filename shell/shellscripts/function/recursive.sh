#!/bin/bash
#A recursive function is a function that repeatedly calls itself.
#No limit is placed on the number of recursive calls. 
#Recursive functions are slow under bash. 
#Avoid using recursive functions if possible. 
#For serious number crunching take a look at the GNU C/C++/Fortran Compiler Collection (GCC).
# fact.sh - Shell script to to find factorial of given command line arg
factorial(){
  local i=$1
  local f
  declare -i i
  declare -i f
 
  # factorial() is called until the value of $f is returned and is it is <= 2
  # This is called the recursion
  [ $i -le 2 ] && echo $i || { f=$(( i - 1)); f=$(factorial $f); f=$(( f * i )); echo $f; }
}
 
 
# display usage
[ $# -eq 0 ] && { echo "Usage: $0 number"; exit 1; }
 
# call factorial
factorial $1
