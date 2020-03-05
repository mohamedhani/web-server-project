
#!/bin/bash
 

source ./basic_configration.sh

local_repo_configration

echo "check of nginx package"
yum list installed | grep -q -i  nginx.x86_64 
if [ $? -ne 0 ]
then 
     echo "download the package ..."
     echo "it may take some mintues based on your internet connection...."
     OS_TYPE=$(hostnamectl status   | grep  -i "cpe os name" | cut -d : -f 4)
     if [ $OS_TYPE == "centos" ] 
     then
        wget https://nginx.org/packages/mainline/centos/7/x86_64/RPMS/nginx-1.17.8-1.el7.ngx.x86_64.rpm > /dev/null 2>&1
     elif [ $OS_TYPE == "enterprise_linux" ]
     then 
          
       wget https://nginx.org/packages/mainline/rhel/7/x86_64/RPMS/nginx-1.17.8-1.el7.ngx.x86_64.rpm > /dev/null 2>&1
     fi
     if [ $? -ne 0 ] 
     then
        echo "can not download the nginx package"
        echo "please check the internet connection"
        exit 2
    fi 
    echo "install nginx"
    yum install -y nginx-1.17.8-1.el7.ngx.x86_64.rpm  > /dev/null  2>&1
    if [ $? -ne 0 ] 
    then 
        echo "cannot install the package"
        exit 3 # connectivity error
   fi
fi

rm -f nginx-1.17.8-1.el7.ngx.x86_64.rpm > /dev/null 2>&1 
yum install -y openssl > /dev/null 2>&1

systemctl enable nginx >> /dev/null 2>&1
systemctl start nginx  >> /dev/null 2>&1
firewall-cmd --add-port=80/tcp  --permanent >> /dev/null  > /dev/null 2>&1
firewall-cmd --add-port=443/tcp --permanent >> /dev/null  > /dev/null 2>&1
firewall-cmd --reload > /dev/null 2>&1 
