#!/bin/bash
NOARGS=65 
NOTFOUND=66 
NOTGZIP=67 
if [ $# -eq 0 ] #  与  if [ -z "$1" ]同样的效果 
#  应该是说前边的那句注释有问题,$1 是可以存在的,比如:zmore "" arg2 arg3 
then
	echo "Usage:`basename $0` filenam" >&2
	 #  错误消息到 stderr
	exit $NOARGS
	 #  脚本返回 65 作为退出码. 
fi

filename=$1

if [ ! -f "$filename" ] #  将$filename ""起来,来允许可能的空白 
then
	echo "File $filename not found!" >&2
	 #  错误消息到 stderr 
	 exit $NOTFOUND 
fi

if [ ${filename##*.} != "gz" ] 
#  在变量替换中使用中括号
then
	 echo "File $1 is not a gzipped file!" 
	 exit $NOTGZIP 
 fi 

 zcat $1 | more
#  使用过滤命令'more' 
 #  如果你想的话也可使用'less' 

exit $?  #  脚本将返回 pipe 的结果作为退出码 
#  事实上,不用非的有"exit $?",但是不管怎么说,有了这句,能正规一些 
#  将最后一句命令的执行状态作为退出码返回
