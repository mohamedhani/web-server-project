#!/bin/bash
  function is_valid_ip 
{  OUTPUT=0
   RE="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
   if [[ $1 =~  $RE ]]
   then
      echo " the ip is not valid"
      OUTPUT=1
   fi
   return $OUTPUT
}
function number_check 
{
     RE="^[0-9]+$"
     OUTPUT=0
     if  [ -z $1 ]
     then
          echo "you dont enter any value" 
     elif  [[ ! $1 =~ $RE ]]
     then
         echo "value you entered is not a number"
     elif [[ $1 -gt $3 || $1 -lt $2 ]]
     then
         echo "enter value between $2 and $3"
     else
        OUTPUT=1
     fi
     return $OUTPUT

}

