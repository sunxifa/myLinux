#!/bin/bash
for i in {a..z} #$(seq 1 100)
do
  echo -en  "\a$i\t"
  sleep 3
done
echo
  