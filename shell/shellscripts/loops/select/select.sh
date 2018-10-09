#!/bin/bash
#Select command use PS3 variable to print its prompt.
# Each word in list is printed on screen preceded by a number.
# If the line consists of the number corresponding to one of the displayed words (from the list), then varName is set to that word. You can use if..else.fi or case..in..esac to make a decision.
# If the line is empty, WORDS and the prompt are redisplayed. 
# If EOF (end of file) is read, the command completes. 
# The loop continues until a break (CTRL+C) is encountered.

# Set PS3 prompt
PS3="Enter the space shuttle to get more information : "
 
# set shuttle list
select shuttle in columbia endeavour challenger discovery atlantis enterprise pathfinder
do
    echo "$shuttle selected"
done
