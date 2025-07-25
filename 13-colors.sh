#!/bin/bash

USERID=$(id -u)
#echo "user id is: $USERID"
R="\e[31m"
G="\e[32m"
N="\e[0m"
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
dnf  list install git

if [ $? -ne 0 ]
then 
   echo "git is not installed, going to install it..."
   dnf install git -y
   VALIDATE $? "installing Git"
else
    echo "git is already installed, nothing to do.."   
fi

dnf list install mysql
if [ $? -ne 0 ]
then 
    echo " mySQL is not installed, going to install"
    dnf install mysql -y
    VALIDATE $? "installing mysql"
else 
    echo "mysql is already installed, nothing to do..."
fi
