#!/bin/bash

SOURCE_DIR=/home/ec2-user/logs #set the directory

if [ -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR Exists"
else
    echo "$SOURCE_DIR does not exists"
    exit 1
fi