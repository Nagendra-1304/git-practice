#!/bin/bash

SOURCE_DIR=/home/ec2-user/logs #set the directory
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ -d $SOURCE_DIR ]
then 
    echo -e "$SOURCE_DIR $G Exists $N"
else
    echo -e "$SOURCE_DIR $R does not exists $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files:: $FILES"

while IFS= read -r line #IFS, Internal field separator, empty means it will ignore white spaces. -r is for not to ignore special character like /

do 
  echo "Deleting line: $line"
  rm -rf $line
done <<< $FILES 