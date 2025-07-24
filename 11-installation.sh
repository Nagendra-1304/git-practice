#!/bin/bash

USERID=$(id -u)
#echo "user id is: $USERID"

if [ $USERID -ne 0 ] 
then 
   echo "please run this script with root privilages"
   exit 1
fi
dnf  list install git 
if [ $? -ne 0 ]
then 
   echo "git is not installed, going to install it..."
   dnf install gittt -y
   if [ $? -ne 0 ]
   then 
       echo "installation is not success, check it.."
       exit 1
   else
     echo "installation is success"
   fi
else
    echo "git is already installed, nothing to do.."   
fi