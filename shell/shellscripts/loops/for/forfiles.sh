#!/bin/bash
# A shell script to verify user password database
#files="/etc/passwd /etc/group /etc/shadow /etc/gshdow"
for f in /etc/passwd /etc/group /etc/shadow /etc/gshdow
do
	[  -f $f ] && echo "$f file found" || echo "*** Error - $f file missing."
done
