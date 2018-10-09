#!/bin/bash

#    "$*"和"$@"的古怪行为, 
#+  依赖于它们是否被""引用. 
#    单词拆分和换行的不一致处理. 
# 注意:$@和$*中的参数只有在""中才会不同.

set -- "First one" "second" "third:one" "" "Fifth: :one" 
#  设置这个脚本参数,$1,$2,等等.

echo

echo 'IFS unchanged,using "$*"'
c=0
for i in "$*"  #  引用
do echo "$((c+=1)):[$i]"
done
echo --- 


echo 'IFS unchanged,using $*'
c=0
for i in $*  #  未引用
do echo "$((c+=1)):[$i]"
done
echo --- 


echo 'IFS unchanged,using "$@"'
c=0
for i in "$@"  #  引用
do echo "$((c+=1)):[$i]"
done
echo ---

echo 'IFS unchanged,using $@'
c=0
for i in $@  
do echo "$((c+=1)):[$i]"
done
echo ---

IFS=:
echo 'IFS=":",using "$*"'
c=0
for i in "$*"
do echo "$((c+=1)):[$i]"
done
echo ---

IFS=:
echo 'IFS=":",using $*'
c=0
for i in $*
do echo "$((c+=1)):[$i]"
done
echo ---

var=$*
echo  'IFS=":", using "$var" (var=$*)' 
c=0 
for i in "$var" 
do echo "$((c+=1)): [$i]" 
done 
echo --- 

echo 'IFS=":", using $var (var=$*)' 
c=0 
for i in $var 
do echo "$((c+=1)): [$i]" 
done 
echo --- 

var="$*" 
echo 'IFS=":", using $var (var="$*")' 
c=0 
for i in $var 
do echo "$((c+=1)): [$i]" 
done 
echo --- 
  
echo 'IFS=":", using "$var" (var="$*")' 
c=0 
for i in "$var" 
do echo "$((c+=1)): [$i]" 
done 
echo --- 
  
echo 'IFS=":", using "$@"' 
c=0 
for i in "$@" 
do echo "$((c+=1)): [$i]" 
done 
echo --- 
  
echo 'IFS=":", using $@' 
c=0   
for i in $@ 
do echo "$((c+=1)): [$i]" 
done 
echo --- 
  
var=$@ 
echo 'IFS=":", using $var (var=$@)' 
c=0 
for i in $var 
do echo "$((c+=1)): [$i]" 
done 
echo --- 
  
echo 'IFS=":", using "$var" (var=$@)' 
c=0 
for i in "$var" 
do echo "$((c+=1)): [$i]" 
done 
echo --- 
  
var="$@" 
echo 'IFS=":", using "$var" (var="$@")' 
c=0 
for i in "$var" 
do echo "$((c+=1)): [$i]" 
done 
echo --- 
  
echo 'IFS=":", using $var (var="$@")' 
c=0 
for i in $var 
do echo "$((c+=1)): [$i]" 
done 
  
echo 
  
#  用 ksh 或者 zsh -y 来试试这个脚本. 
  
exit 0 
  
# This example script by Stephane Chazelas, 
# and slightly modified by the document author. 
