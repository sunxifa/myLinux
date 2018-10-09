#!/bin/bash
LOG=$0.log 
  
COMMAND1="sleep 100" 
  
echo "Logging PIDs background commands for script: $0" >> "$LOG" 
#  所以它们可以被监控,并且在必要的时候 kill 掉. 
echo >> "$LOG" 
  
# Logging  命令. 

echo -n "PID of \"$COMMAND1\":    " >> "$LOG" 
${COMMAND1} & 
echo $! >> "$LOG" 
# PID of "sleep 100":    1506 
  
# Thank you, Jacques Lederer, for suggesting this. 
# possibly_hanging_job & { sleep ${TIMEOUT}; eval 'kill -9 $!' &> /dev/null; } 
#  强制结束一个品行不良的程序. 
#  很有用,比如在 init 脚本中. 
