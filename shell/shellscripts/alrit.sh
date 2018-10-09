#!/bin/bash 
# Counting to 11 in 10 different ways. 
  
n=1; echo -n "$n " 
  
let "n = $n + 1"      # let "n = n + 1"    这么写也行 
echo -n "$n " 
  
  
: $((n = $n + 1)) 
#    ":"  是必须的,这是因为,如果没有":"的话,Bash 将 
#+  尝试把"$((n = $n + 1))"解释成一个命令 
echo -n "$n " 
  
(( n = n + 1 ))  #    对于上边的方法的一个更简单的选则. 
#    Thanks, David Lombard, for pointing this out. 
echo -n "$n " 
  
n=$(($n + 1)) 
echo -n "$n " 
  
: $[ n = $n + 1 ] 
#    ":"  是必须的,这是因为,如果没有":"的话,Bash 将 
#+  尝试把"$[ n = $n + 1 ]"  解释成一个命令 
#    即使"n"被初始化成为一个字符串,这句也能工作. 
echo -n "$n " 
  
n=$[ $n + 1 ] 
#    即使"n"被初始化成为一个字符串,这句也能工作. 
#* Avoid this type of construct, since it is obsolete and nonportable. 
#*  尽量避免这种类型的结果,因为这已经被废弃了,并且不具可移植性. 
#    Thanks, Stephane Chazelas. 
echo -n "$n " 
  
#  现在来个 C 风格的增量操作. 
# Thanks, Frank Wang, for pointing this out. 
  
let "n++"                    # let "++n"    also works. 
echo -n "$n " 
  
(( n++ ))                    # (( ++n )    also works. 
echo -n "$n " 
  
: $(( n++ ))              # : $(( ++n )) also works. 
echo -n "$n " 
  
: $[ n++ ]                  # : $[ ++n ]] also works 
echo -n "$n " 
  
echo 
  
exit 0 
