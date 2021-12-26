#!/bin/bash
echo "$(system_profiler SPPowerDataType | grep "State of Charge" | cut -d ':' -f 2 | sed 's/ //')%"
