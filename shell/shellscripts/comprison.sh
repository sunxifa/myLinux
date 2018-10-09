#!/bin/bash 
  
a=4 
b=5 
  
#    这里的变量 a 和 b 既可以当作整型也可以当作是字符串. 
#    这里在算术比较和字符串比较之间有些混淆, 
#+  因为 Bash 变量并不是强类型的. 
  
#    Bash 允许对整型变量操作和比较 
#+  当然变量中只包含数字字符. 
#    但是还是要考虑清楚再做. 
  
echo 
  
if [ "$a" -ne "$b" ] 
then 
     echo "$a is not equal to $b" 
     echo "(arithmetic comparison)" 
fi 
  
echo 
  
if [ "$a" != "$b" ] 
then 
     echo "$a is not equal to $b." 
     echo "(string comparison)" 
     #          "4"    != "5" 
     # ASCII 52 != ASCII 53 
fi 
  
#  在这个特定的例子中,"-ne"和"!="都可以. 
  
echo 
  
exit 0 
