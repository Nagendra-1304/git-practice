#!/bin/bash

USERID=$(id -u)
#echo "user id is: $USERID"
VALIDATE()
{
  if [ $1 -ne 0 ]
  then 
      echo "$2 is failed...."
      exit 1
  else 
     echo "$2 is success"
  fi      
}
if [ $USERID -ne 0 ] 
then 
   echo "please run this script with root privilages"
   exit 1
fi
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
