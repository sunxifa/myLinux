#Write the shell program which produces a report from the output of ls -l in the following format:
#!/bin/bash
 
#copying the out of ls -l command to a file
ls -l > /tmp/tmp.tmp
 
#initilizing values
sum=0
dir=0
file=0
link=0
 
#reading the file
while read line
do 
	#getting the first character of each line to check the type of file 	
	read -n 1 c <<< $line
 
	#checking if the file is a directory or not
	if [ $c == "d" ] 
	then
		((dir++))
		echo "[DIR] ${line}/" | cut -d" " --fields="1 9" >> /tmp/dir.tmp
 
	elif [ $c == "-" ] #true if the file is a regular file
	then
		((file++))
		echo $line | cut -d" " -f8 >> /tmp/file.tmp
 
	elif [ $c == "l" ]  #true if the file is a symbolic link
	then
		((link++))
	fi
 
	size=$( echo $line | cut -d" " -f5 ) #getting the size of the file
	sum=$(( sum+size )) #adding the size of all the files 
done < /tmp/tmp.tmp
 
cat /tmp/file.tmp #output the name of all the files
cat /tmp/dir.tmp #output the name of all the directory
 
echo "Total regular files = $file"
echo "Total directories = $dir"
echo "Total symbolic links = $link"
echo "Total size of regular file = $size"
 
#removing the temporary files
rm /tmp/file.tmp
rm /tmp/dir.tmp
rm /tmp/tmp.tmp
