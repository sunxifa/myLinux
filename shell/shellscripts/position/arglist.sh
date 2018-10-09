#!/bin/bash

#  多使用几个参数来调用这个脚本,比如"one tow three". 

E_BADARGS=65

if [ ! -n "$1" ]
then
	echo "Usage:`basename $0` argument1 argument2 etc"
	exit $E_BADARGS
fi

echo

index=1

echo "Listing args with \"\$*\":"

for arg in "$*"  #  如果"$*"不被""引用,那么将不能正常地工作 
do
	echo "Arg #$index=$arg"
	let "index+=1"
done    # $* sees all arguments as single word.
echo "Entire arg list seen as single world."

echo

index=1

echo  "Listing args with \"\$@\":" 
for arg in "$@"
do
	echo "Arg #$index=$arg"
	 let "index+=1"
done   # $@  认为每个参数都一个单独的单词. 
echo "Arg list seen as separate words."

echo

index=1

echo "Listing args with \$* (unquoted):" 
for arg in $*
do
	echo "Arg #$index=$arg"
	let "index+=1"
done  #  未""引用的$*把参数作为独立的单词. 
echo "Arg list seen as separate words."  

exit 0
