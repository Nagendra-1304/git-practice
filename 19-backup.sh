#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if $3 is empty, default is 14 days
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

USAGE()
{
    echo -e "$R USAGE :: $N sh 19-backup.sh <source> <destination> <days(optional)>"
}

#check the source and destination are provided

if [ $# -lt 2 ]
then 
   USAGE
fi   

if [ ! -d $SOURCE_DIR ]
then 
    echo " $SOURCE_DIR does not exist..please check"
fi   

if [ ! -d $DEST_DIR ]
then 
    echo " $DEST_DIR does not exist..please check"
fi

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)

echo "Files: $FILES"

if [ ! -z "$FILES" ] #true if FILES is empty, ! makes it expression false
then 
    echo "files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@

    #check if zip file is successfully created or not
    if [ -f $ZIP_FILE ]
    then 
        echo "successfully zipped files older than $DAYS"
        #remove the files after zipping
        while IFS= read -r file #IFS, Internal field separator, empty means it will ignore white spaces. -r is for not to ignore special character like /
        do 
          echo "Deleting file: $file"
          rm -rf $file
        done <<< $FILES 
    else 
        echo "Zipping the files is failed"
        exit 1
    fi
else
    echo "No files older than $DAYS"
fi