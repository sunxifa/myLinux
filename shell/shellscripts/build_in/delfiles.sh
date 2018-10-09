#!/bin/bash 
  
E_WRONG_DIRECTORY=73    
clear #  清屏. 
  
TargetDirectory=/home/bozo/projects/GreatAmericanNovel 
  
cd $TargetDirectory 
echo "Deleting stale files in $TargetDirectory." 
  
if [ "$PWD" != "$TargetDirectory" ] 
then        #  防止偶然删除错误的目录 
     echo "Wrong directory!" 
     echo "In $PWD, rather than $TargetDirectory!" 
     echo "Bailing out!" 
     exit $E_WRONG_DIRECTORY 
fi     
  
rm -rf * 
rm .[A-Za-z0-9]*        # Delete dotfiles. 
rm .[A-Za-z0-9]*        #  删除"."文件(隐含文件). 
# rm -f .[^.]* ..?*      为了删除以多个"."开头的文件. 
# (shopt -s dotglob; rm -f *)      也行. 
# Thanks, S.C. for pointing this out. 
  
#  文件名能够包含 0-255 范围的所有字符,除了"/". 
#  删除以各种诡异字符开头的文件将作为一个练习留给大家. 
  
#  这里预留给其他的必要操作. 
  
echo 
echo "Done." 
echo "Old files deleted in $TargetDirectory." 
echo 
  
  
exit 0 
