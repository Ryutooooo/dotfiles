#!/bin/bash
if [[ $1 = "usage" ]];then
  top -l 1 -s 0 | grep PhysMem | awk '{print $2}'
else
  info=$(system_profiler SPHardwareDataType | grep 'Memory'); echo "${info#*: }" | sed -e 's/ //' | sed -e 's/B//'
fi
