#!/bin/bash 
source ./basic_configration.sh
local_repo_configration
echo "check of apache  package"
yum list installed  httpd  > /dev/null 2>&1
if [ $? -ne 0 ]
then 
     yum install -y httpd  > /dev/null 2>&1
fi


systemctl start httpd > /dev/null 2>&1
systemctl enable httpd > /dev/null 2>&1
firewall-cmd --add-port=80/tcp  --permanent >> /dev/null  > /dev/null 2>&1
firewall-cmd --add-port=443/tcp --permanent >> /dev/null  > /dev/null 2>&1
firewall-cmd --reload > /dev/null 2>&1



echo "apache has been installed"
echo "check of the openssl"
yum list installed  openssl  > /dev/null 2>&1
if [ $? -ne 0 ]
then 
    yum install -y httpd  > /dev/null 2>&1
fi
echo "openssl has been installed"




