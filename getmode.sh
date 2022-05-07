#!/bin/bash

minspeeds=""
for minspeed in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_min_freq; do
    if [ -z $minspeeds ]; then
        minspeeds=$(cat $minspeed)
    else
        if [ "$(cat $minspeed)" != "$minspeeds" ]; then
            minspeeds="$minspeeds,$(cat $minspeed)"
        fi
    fi
done

maxspeeds=""
for maxspeed in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_max_freq; do
    if [ -z $maxspeeds ]; then
        maxspeeds=$(cat $maxspeed)
    else
        if [ "$(cat $maxspeed)" != "$maxspeeds" ]; then
            maxspeeds="$maxspeeds,$(cat $maxspeed)"
        fi
    fi
done


if [ "$minspeeds" == "$maxspeeds" ]; then
    echo "Fixed speed(s): $(($maxspeeds/1000)) MHz"
else 
    echo "Minimum speed(s): $(($minspeeds/1000)) MHz"
    echo "Maximum speed(s): $(($maxspeeds/1000)) MHz"
fi


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


average=0
count=0

for speed in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq; do
    ((average+=$(cat $speed)))
    ((count+=1))
done

echo "Current average core speed: $((average/count/1000)) MHz"