#!/bin/bash

USERID=$(id -u)
#echo "user id is: $USERID"
R="\e[31m"
G="\e[32m"
N="\e[0"
CHECK_ROOT()
{
    if [ $USERID -ne 0 ]
    then 
           echo "please run this script with root privilages"
           exit 1
    fi       
}
VALIDATE()
{
  if [ $1 -ne 0 ]
  then 
      echo -e  "$2 is $R failed.... $N"
      exit 1
  else 
     echo -e "$2  $G is success $N"
  fi      
}
CHECK_ROOT

# sh 15-Loops.sh git nginx mysql postfix
for package in $@ # $@ refers to all arguments passed to it
do
dnf list installed $package
if [ $? -ne 0 ]
then 
    echo "$package is not installed, going to install it.."
    dnf install $package -y
    VALIDATE $? "installing $package"
else
    echo "$package is already installed. nothing to do"
fi
done