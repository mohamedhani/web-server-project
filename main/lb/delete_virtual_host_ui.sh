#!/bin/bash 
source ./global_function.sh
source delete_web_server.sh 
FLAG=0
while [ $FLAG -eq 0 ]
do
    read -e -p "enter the ip of web server eg(192.168.5.5) :" IP
    if ! is_valid_ip $IP 
    then 
        echo "this ip is not valid"
    else
       FLAG=1
    fi 

      
done

if delete_server_from_lb $IP 
then 
 echo "ip has been removed"
else 
 echo "this ip is not exists"
fi
 
#cut -d " " -f 2  /etc/nginx/conf.d/web_server_lb | cut -d : -f 1 | grep -q  $IP
#if [ $? -ne 0  ]
#then 
#    echo "this ip is not  exists"
#else
#    echo "ip has beed removed"

#fi 
