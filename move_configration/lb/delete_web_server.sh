#!/bin/bash
#$1 ip
function delete_server_from_lb
 
{ 
  CONF_FILE="/etc/nginx/conf.d/web_server_lb"  
  EXIT_CODE=0
  grep -q $1 $CONF_FILE
  if [ $? -eq 0 ] 
  then 
          SERVERS=$( grep -v $1  /etc/nginx/conf.d/web_server_lb )
          echo $SERVERS > $CONF_FILE
           nginx -s reload 
  else
         EXIT_CODE=1
  fi 
  return $EXIT_CODE
}
