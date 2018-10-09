#!/bin/bash

#TMOUT=3 

TIMELIMIT=3  #  在这个例子上是 3 秒,也可以设其他的值.

PrintAnswer()
{
	#[ -z "$answer" ]&&(echo "Input cannot be null";kill $!;exit 1;)
	[ -z "$answer" ]&&{ echo "Input cannot be null";kill $!;exit 1; }
	if [ "$answer" = TIMEOUT ]
	then
		echo $answer
	else
		echo "Your favorite veggie is $answer"
		kill $!
		 # kill 将不再需要 TimerOn 函数运行在后台.
		 # $!  是运行在后台的最后一个工作的 PID.
	fi
}

TimerON()
{
	sleep $TIMELIMIT && kill -s 14 $$ &
	  #  等待 3 秒,然后发送一个信号给脚本. 
}
Int14Vector()
{
	answer="TIMEOUT"
	PrintAnswer
	exit 14
}

trap Int14Vector 14      #  为了我们的目的,时间中断(14)被破坏了.

echo "What is your favorite vegetabls"
TimerON
read answer
PrintAnswer

#很明显的,这是一个拼凑的实现. 
#+  然而使用"-t"选项来"read"的话,将会简化这个任务. 
#    见"t-out.sh",在下边
exit 0
