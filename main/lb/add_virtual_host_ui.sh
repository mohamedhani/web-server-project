#!/bin/bash
MACHINE_IPS=$( hostname -I )
echo "select the listen ip "
select IP in $MACHINE_IPS ALL
do
   if [ -z $IP ] 
   then 
      echo "you select wrong ip"
  else 
     
     if [ $IP == "ALL" ]
     then 
       IP="*"
    fi
    break
  fi
done
read -e -p "enter the domain name : eg (example.com)" DOMAIN_NAME
if [ -z $DOMAIN_NAME ] 
then 
  echo "you dont enter the domain name"
  exit 1 
 echo $DOMAIN_NAME

elif  ! echo $DOMAIN_NAME | grep -q -e ".\{3,9\}\..\{2,5\}" 
then
  echo "domain name is wrong"
  exit 2 
fi 
 
 ls /etc/nginx/conf.d/ | grep  -q $DOMAIN_NAME.conf

if [ $? -eq 0 ]
then 
   echo "this domain already exists"
   exit 0
fi 
./add_virtual_host.sh $IP $DOMAIN_NAME
