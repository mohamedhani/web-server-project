#!/bin/bash
source global_function.sh
FLAG=0
while [ $FLAG -eq 0 ]
do 
      read -e -p "enter the apache server ip eg(192.168.1.5) : " IP
      is_valid_ip $IP
      if [ $? -eq 0 ]
      then 
         FLAG=1
      else
          echo "the ip is not valid"
      fi
done
FLAG=0
while [ $FLAG  -eq 0 ]
do
     read -e -p "enter the weight ( number between 1 and 50) : " WIEGHT
     number_check $WIEGHT 1 50
     FLAG=$?
done
FLAG=0
while [ $FLAG -eq 0 ]
do 
   read -e -p "enter the max number of fail (number between 1 20 ) : " MAX_FAIL
    number_check $MAX_FAIL 1 20 
    FLAG=$?
done
FLAG=0
while [ $FLAG -eq 0 ]
do 
   read -e -p  "enter the max time out of server (number between 1 30 in sec ) : " TIME_OUT
   number_check $TIME_OUT 1 30
   FLAG=$? 
done
./add_web_server.sh $IP $WIEGHT  $MAX_FAIL $TIME_OUT
