#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5 #In real projects it is usually 75

while IFS= read -r line #IFS, Internal field separator, empty means it will ignore white spaces. -r is for not to ignore special character like /
do 
    USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -gt $DISK_THRESHOLD ]
    then 
        echo "$PARTITION is more than $DISK_THRESHOLD, current value: $USAGE. please check"
    fi
done <<< $DISK_USAGE        