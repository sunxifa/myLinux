#Write a shell script to determine if an input number is a palindrome or not. A palindromic number is a number where the digits, with decimal representation usually assumed, are the same read backwards, for example, 58285.
#!/bin/bash
echo -n "Enter number : "
read n
 
# store single digit
sd=0
 
# store number in reverse order
rev=""
 
# store original number
on=$n
 
while [ $n -gt 0 ]
do
    sd=$(( $n % 10 )) # get Remainder
    n=$(( $n / 10 ))  # get next digit
    # store previous number and current digit in reverse
    rev=$( echo ${rev}${sd} )
done
 
if [ $on -eq $rev ];
then
  echo "Number is palindrome"
else
  echo "Number is NOT palindrome"
fi
