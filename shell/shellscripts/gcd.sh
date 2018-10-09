#!/bin/bash 
# gcd.sh:  最大公约数 
#                  使用 Euclid's  算法 
  
#    最大公约数,就是 2 个数能够同时整除的最大的数. 
#   
#    Euclid's 算法采用连续除法. 
#    在每个循环中 
#+  被除数  <---    除数 
#+  除数  <---    余数 
#+  直到余数= 0. 
#+  在最后的循环中 The gcd =  被除数 
# 
#    关于这个算法更精彩的讨论 
#    见 Jim Loy's site, http://www.jimloy.com/number/euclids.htm. 
  
  
# ------------------------------------------------------ 
#  参数检查 
ARGS=2 
E_BADARGS=65 
  
if [ $# -ne "$ARGS" ] 
then 
     echo "Usage: `basename $0` first-number second-number" 
     exit $E_BADARGS 
fi 
# ------------------------------------------------------ 
  
  
gcd () 
{ 
  
     dividend=$1                                        #    随便给值 
     divisor=$2                                          #+  即使$2 大,也没关系. 
                                                                   #    Why not? 
  
     remainder=1                                        #    如果在循环中使用未初始化的变量. 
                                                                   #+  那将在第一次循环中产生一个错误消息. 
                                                                    
  
     until [ "$remainder" -eq 0 ] 
     do 
         let "remainder = $dividend % $divisor" 
         dividend=$divisor                        #  现在使用 2 个最小的数重复. 
         divisor=$remainder 
     done                                                      # Euclid's algorithm 
  
}                                                                # Last $dividend is the gcd. 50 }                                                                #  最后的$dividend 就是 gcd. 
  
  
gcd $1 $2 
  
echo; echo "GCD of $1 and $2 = $dividend"; echo 
  
  
#  练习: 
# -------- 
#    检查命令行参数来确定它们都是整数, 
#+ and exit the script with an appropriate error message if not. 
#+  否则就选择合适的错误消息退出. 
  
exit 0 
