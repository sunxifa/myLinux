#Write a shell program to read a number and display reverse the number. For example, 123 should be printed as as 321.
#!/bin/bash
 
#store the no
num=$1
 
#store the reverse number
rev=0
 
if [ $# -ne 1 ]
then
	echo "$0 number"
	exit 1
fi
 
while [ $num -gt 0 ] 
do
	digit=$(( num%10 ))
	num=$(( num/10 ))
	rev=$(( digit + rev*10 ))
done 
 
echo "Reverse of number = $rev"
