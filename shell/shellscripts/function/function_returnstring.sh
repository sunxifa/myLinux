#!/bin/bash
#You cannot return a word or anything else from a function. 
#However, you can use echo or printf command to send back output easily to the script.
# Variables
domain="CyberCiti.BIz"
out=""
 
##################################################################
# Purpose: Converts a string to lower case
# Arguments:
#   $@ -> String to convert to lower case
##################################################################
function to_lower() 
{
    local str="$@"
    local output
    output=$(tr '[A-Z]' '[a-z]'<<<"${str}")
    echo $output
}
 
# invoke the to_lower()
to_lower "This Is a TEST"
 
# invoke to_lower() and store its result to $out variable
out=$(to_lower ${domain})
 
# Display  back the result from $out
echo "Domain name : $out"
