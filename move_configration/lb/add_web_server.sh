#!/bin/bash


RETURN_CODE=0
#$1  ip 
#$2 weight 
#$3 max_fail 
#$4 max_time_out
CONF_FILE="/etc/nginx/conf.d/web_server_lb"
grep -q $1 $CONF_FILE
if [ $? -eq 0 ] 
then 
  echo "this server is aleady exist";
fi
echo "server $1:443 weight=$2  max_fails=$3 fail_timeout=$4s;" >> $CONF_FILE
nginx -s reload > /dev/null 2>&1

if [ $? -ne 0 ]
then 
   echo "there is a problem in the configration file"
   RETURN_CODE=1
else
  echo "the server has been added"
fi
exit $RETURN_CODE
