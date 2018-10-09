#Write a shell program to read a number *such as 123) and find the sum of digits (1+2+3=6).
#!/bin/bash
 
#store the no
num=$1
 
#store the value of sum
sum=0
 
if [ $# -ne 1 ]
then
	echo "$0 number"
	exit 1
fi
 
while [ $num -gt 0 ] 
do
	digit=$(( num%10 ))
	num=$(( num/10 ))
	sum=$(( digit+sum ))
done 
 
echo "Sum of digits = $sum"
