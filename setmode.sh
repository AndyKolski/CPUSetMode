#!/bin/bash

if ! command -v cpufreq-set &> /dev/null
then
    echo "cpufreq-set could not be found, and is needed for this script"
    exit
fi


hasSudo=$(expr "0" == "$EUID")

if sudo true; then
    hasSudo=1
else
    echo "This script needs root, and could not authenticate. Exiting."
    exit 1
fi

case $1 in 

    "performance" | "high")
    governor="performance"
    freq_low="400MHz"
    freq_high="4200MHz"
    ;;

    "powersave" | "powersaver" | "low")
    governor="powersave"
    freq_low="400MHz"
    freq_high="1200MHz"
    ;;

    "spud")
    governor="powersave"
    freq_low="400MHz"
    freq_high="400MHz"
    ;;

    "set" | "freq" | "setfreq")
    governor="powersave"
    freq_low="$2"
    freq_high="$2"
    ;;

    *)
    echo "Usage: $0 [performance|powersave|spud|freq]"
    exit 1
    ;;
esac

echo "setting cpu to $governor governor at $freq_low - $freq_high"

numCores=$(nproc)

for i in $(seq 0 $((numCores-1))); do
    sudo cpufreq-set -c $i -g $governor -d $freq_low -u $freq_high
done