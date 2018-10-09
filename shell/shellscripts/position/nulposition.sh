#!/bin/bash 
  
#    如果$IFS 被设置为空时, 
#+  那么"$*"  和"$@"  将不会象期望那样 echo 出位置参数. 
  
mecho ()              # Echo  位置参数. 
{ 
echo "$1,$2,$3"; 
} 
  
  
IFS=""                  #  设置为空. 
set a b c            #  位置参数. 
  
mecho "$*"          # abc,, 
mecho $*              # a,b,c 
  
mecho $@              # a,b,c 
mecho "$@"          # a,b,c 
  
#    当$IFS 设置为空时,$*  和$@  的行为依赖于 
#+  正在运行的 Bash 或者 sh 的版本. 
#    所以在脚本中使用这种"feature"不是明智的行为. 
  
  
# Thanks, Stephane Chazelas. 
  
exit 0 
