#!/bin/bash
 [ $# -eq 0 ] && directorys=`pwd` || directorys=$@ 
 linkchk () { 
          for element in $1/*; do 
          [ -h "$element" -a ! -e "$element" ] && echo \"$element\" 
          [ -d "$element" ] && linkchk $element 
          # Of course, '-h' tests for symbolic link, '-d' for directory. 
          #  当然'-h'是测试链接,'-d'是测试目录. 
          done 
 }
for directory in $directorys; do 
          if [ -d $directory ] 
   then linkchk $directory 
   else   
           echo "$directory is not a directory" 50          
	   echo "Usage: $0 dir1 dir2 ..." 
          fi 
 done 
   
 exit 0  
