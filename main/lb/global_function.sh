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
