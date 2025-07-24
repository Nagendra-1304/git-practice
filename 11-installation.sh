#!/bin/bash

USERID=$(id -u)
#echo "user id is: $USERID"

if [ $USERID -ne 0 ] 
then 
   echo "please run this scriot with root privilages"

fi
dnf install git -y

ls -ltr
lsssss -sss
ls -la
