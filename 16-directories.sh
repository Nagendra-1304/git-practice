#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "."  -f1)
TIMESTAPM=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAPM.log"
mkdir -p $LOGS_FOLDER



USERID=$(id -u)
#echo "user id is: $USERID"
R="\e[31m"
G="\e[32m"
N="\e[0"
Y="\e[33m"
CHECK_ROOT()
{
    if [ $USERID -ne 0 ]
    then 
           echo -e  "$R please run this script with root privilages $N" &>>$LOG_FILE #To store in the log file.
           exit 1
    fi       
}
VALIDATE()
{
  if [ $1 -ne 0 ]
  then 
      echo -e  "$2 is $R failed.... $N" | tee -a $LOG_FILE
      exit 1
  else 
     echo -e "$2  $G is success $N" | tee -a $LOG_FILE
  fi      
}

USAGE()
{
    echo -e "$R USAGE:: $N sudo sh 16-directories.sh package1 package2 ..."
    exit 1
}
echo "script started executing at: $(date)" | tee -a $LOG_FILE
CHECK_ROOT
if [ $# -eq 0 ]
then 
    USAGE
fi

# sh 15-Loops.sh git nginx mysql postfix
for package in $@ # $@ refers to all arguments passed to it
do
dnf installed $package &>>$LOG_FILE
if [ $? -ne 0 ]
then 
    echo "$package is not installed, going to install it.." | tee -a $LOG_FILE
    dnf install $package -y &>>$LOG_FILE
    VALIDATE $? "installing $package"
else
    echo -e "$Y $package is already  installed. nothing to do $N" | tee -a $LOG_FILE
fi
done