#!/bin/bash 
# numbers.sh:  数字常量的几种不同的表示法 
  
# 10 进制:  默认 
let "dec = 32" 
echo "decimal number = $dec"                          # 32 
#  一切都很正常 
  
  
# 8 进制:  以'0'(零)开头 
let "oct = 032" 
echo "octal number = $oct"                              # 26 
#  表达式的结果用 10 进制表示. 
#   15   
# 16 进制表示:数字以'0x'或者'0X'开头 
let "hex = 0x32" 
echo "hexadecimal number = $hex"                  # 50 
#  表达式的结果用 10 进制表示. 
  
#  其它进制: BASE#NUMBER 
# BASE between 2 and 64. 
# 2 到 64 进制都可以. 
# NUMBER 必须在 BASE 的范围内,具体见下边. 
  
  
let "bin = 2#111100111001101" 
echo "binary number = $bin"                            # 31181 
  
let "b32 = 32#77" 
echo "base-32 number = $b32"                          # 231 
  
let "b64 = 64#@_" 
echo "base-64 number = $b64"                          # 4031 
#  这种 64 进制的表示法中的每位数字都必须在 64 进制表示法的限制字符内. 
# 10  个数字+ 26  个小写字母+ 26  个大写字母+ @ + _ 
  
  
echo 
  
echo $((36#zz)) $((2#10101010)) $((16#AF16)) $((53#1aA)) 
                                                                                   # 1295 170 44822 3375 
  
  
#    重要的注意事项: 
#    --------------- 
#    如果使用的每位数字超出了这个进制表示法规定字符的范围的话, 
#+  将给出一个错误消息. 
  
let "bad_oct = 081" 
# (部分的)  错误消息输出: 
#    bad_oct = 081: too great for base (error token is "081") 
#                            Octal numbers use only digits in the range 0 - 7. 
  
exit 0              # Thanks, Rich Bartell and Stephane Chazelas, for clarification. 
