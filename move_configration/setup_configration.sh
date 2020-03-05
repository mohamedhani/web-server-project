#!/bin/bash

# !/bin/bash
function CHECK_IP
{
  is_valid_ip $1
  if [ $? -eq 1 ]  # ip is not valid 
  then
     echo "this ip is not valid"
     return 1
  fi 
  ping_ip $1
  if [ $? -eq 1 ]
  then 
     echo "this ip is not reachalbe"
     return 2 
  fi
	
}


 function ping_ip
{ 
  OUTPUT=0
  ping -c 1 $DNS_IP > /dev/null 2>&1
  if [ $? -ne 0 ]
  then 
      OUTPUT=1
  fi 
  return $OUTPUT
}
  function is_valid_ip 
{  OUTPUT=0
   RE="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
   if [[ ! $1 =~ $RE ]]
   then 
      OUTPUT=1
   fi
   return $OUTPUT
}



