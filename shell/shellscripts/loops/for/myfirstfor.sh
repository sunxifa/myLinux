#!/bin/bash
# define an array   
#ArrayName=(/etc/*.conf)
#filelist=/etc/*.conf
#for var in "${ArrayName[@]}" 
for var in /etc/*.conf
do
       echo  "$var"
done
