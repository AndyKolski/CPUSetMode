#!/bin/bash

if ! command -v cpufreq-set &> /dev/null
then
    echo "cpufreq-set could not be found, and is needed for this script"
    exit
fi


average=0
count=0

for speed in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq; do
    ((average+=$(cat $speed)))
    ((count+=1))
done

echo "Average core speed: $((average/count/1000)) MHz"


governors=""
for governor in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_governor; do
    if [ -z $governors ]; then
        governors=$(cat $governor)
    else
        if [ "$(cat $governor)" != "$governors" ]; then
            governors="$governors,$(cat $governor)"
        fi
    fi
done

echo "Governor(s): $governors"