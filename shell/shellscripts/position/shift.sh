#!/bin/bash
echo "$@"
shift
echo "$@"
shift
echo "$@"
shift
echo "$*"
#  每个"shift"都丢弃$1. 
# "$@"  将包含剩下的参数. 
