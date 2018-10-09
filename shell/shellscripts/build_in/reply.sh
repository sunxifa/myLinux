#!/bin/bash
# REPLY 是'read'命令结果保存的默认变量. 

echo
echo -n  "What is your favorite vegetable? " 
read

echo "Your favorite vegetable is $REPLY." 
#    当且仅当在没有变量提供给"read"命令时, 
#+ REPLY 才保存最后一个"read"命令读入的值. 

echo
echo -n "What is your favorite fruit?"
read fruit
echo "Your favorit fruit is $fruit."
echo "but..."
echo "Value pf \$REPLY is still $REPLY."
#    $REPLY 还是保存着上一个 read 命令的值,   
#+  因为变量$fruit 被传入到了这个新的"read"命令中.

echo

exit 0
