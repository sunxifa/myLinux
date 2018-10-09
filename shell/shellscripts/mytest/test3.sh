#!/bin/bash
#Write a shell script that, given a file name as the argument will write the even numbered line to a file with name evenfile and odd numbered lines in a text file called oddfile.
file=$1
counter=0
 
if [ $# -ne 1 ]
then
	echo "$0 fileName"
	exit 1
fi
if [ ! -f $file ]
then
	echo "$file not a file"
	exit 2
fi
 
while read line
do
	((counter++))
	EvenNo=$(( counter%2 ))
 
	if [ $EvenNo -eq 0 ] 
	then
		echo $line >> evenfile 
	else
		echo $line >> oddfile
	fi
 
done < $file
