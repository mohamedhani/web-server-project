#!/bin/bash 
source setup_configration.sh
FLAG=0
while [ $FLAG -eq 0 ]
do
    read -e -p "enter the ip of dns server  eg(192.168.101.5) : " DNS_IP
    is_valid_ip $DNS_IP
    if [ $? -ne 0 ] 
    then
          echo "this ip is not valid"
          continue 
    fi
    ping -c 1 $DNS_IP > /dev/null 2>&1
    if [ $? -ne 0 ]
    then 
         echo "this ip is not reachable"
    else 
        FLAG=1
    fi
done
read -e -p "enter the user of dns server : " DNS_USER
read -e -p "enter the password of dns server : " DNS_PASSWORD
sshpass -p "$DNS_PASSWORD" scp -r  dns $DNS_USER@$DNS_IP:/home/$DNS_USER/bin
if [ $? -ne 0 ]
then 
    echo "this username or password are wrong"
    exit 1
fi
echo "dns:$DNS_IP:$DNS_USER:$DNS_PASSWORD" > ../main/machines

sshpass -p "$DNS_PASSWORD" ssh $DNS_USER@$DNS_IP "~/bin/dns/setup.sh"

FLAG=0
while [ $FLAG -eq 0 ]  #enter the nfs ip 
do
    read -e -p "enter the ip of nfs  eg(192.168.101.5) : " NFS_IP
    is_valid_ip $NFS_IP
    if [ $? -ne 0 ]
    then
          echo "this ip is not valid"
          continue
    fi
    ping -c 1 $NFS_IP > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
         echo "this ip is not reachable"
    else
        FLAG=1
    fi
done
read -e -p "enter the user of nfs server : " NFS_USER
read -e -p "enter the password of nfs server : " NFS_PASSWORD
sshpass -p "$NFS_PASSWORD" scp -r  nfs $NFS_USER@$NFS_IP:/home/$NFS_USER/bin
if [ $? -ne 0 ]
then
    echo "this username or password are wrong"
    exit 2
fi

sshpass -p "$NFS_PASSWORD" ssh $NFS_USER@$NFS_IP "~/bin/nfs/setup.sh"

echo "nfs:$NFS_IP:$NFS_USER:$NFS_PASSWORD" > ../main/machines


FLAG=0
while [ $FLAG -eq 0 ]  #enter the load balancer ip 
do
    read -e -p "enter the ip of lb server eg(192.168.101.5) : " LB_IP
    is_valid_ip $NFS_IP
    if [ $? -ne 0 ]
    then
          echo "this ip is not valid"
          continue
    fi
    ping -c 1 $NFS_IP > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
         echo "this ip is not reachable"
    else
        FLAG=1
    fi
done
read -e -p "enter the user of lb server : " LB_USER
read -e -p "enter the password of lb server : " LB_PASSWORD
sshpass -p "$LB_PASSWORD" scp -r  lb $LB_USER@$LB_IP:/home/$LB_USER/bin
if [ $? -ne 0 ]
then
    echo "this username or password are wrong"
    exit 3
fi
echo "lb:$LB_IP:$LB_USER:$LB_PASSWORD" > ../main/machines

sshpass -p "$LB_PASSWORD" ssh $LB_USER@$LB_IP "~/bin/lb/setup.sh"
exit 0





