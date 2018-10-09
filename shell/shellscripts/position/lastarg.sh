#!/bin/bash 
  
echo $_                            # /bin/bash 
                                           #  只是调用/bin/bash 来运行这个脚本. 
  
du >/dev/null                #  将没有命令的输出 
echo $_                            # du 
  
ls -al >/dev/null        #  没有命令输出 
echo $_                            # -al    (最后的参数) 
   : 
echo $_                            # : 
