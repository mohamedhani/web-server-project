#!/bin/bash

if [ !  -f  ./machines ]  #check of the files that have the ips and users of server
then
   echo "the machines file is not found"   
   exit 1
else  # read the ips and users of servers
    DNS_IP=$( grep  -e "^dns:" machines | cut -f 2 -d : )
    DNS_USER=$(grep -e "^dns:" machines | cut -f 3 -d : )
    NFS_IP=$( grep  -e "^nfs:" machines | cut -f 2 -d : )
    NFS_USER=$(grep -e "^nfs:" machines | cut -f 3 -d : )
    LB_IP=$( grep  -e "^lb:" machines | cut -f 2 -d : )
    LB_USEE=$(grep -e "^lb:" machines | cut -f 3 -d : )
fi
echo " The Main Menu Configuration "
select name in "Virtual Hosting"  "DNS Operations" "Load balancer"  "Configure a Web Server"  "Configure NFS" " exit"
do
 	if [[ $name == "Virtual Hosting" ]]
		then
	    		select vname in "Add domain"  "Delete domain"  "Suspend domain" "Resume domain" "List all enable domains"  "List all suspended domains" "exit"
            		do
				if [[ $vname == "Add domain" ]]
                			then
                                		echo "$vname selected"
				
				elif [[ $vname == "Delete domain" ]]
                                        then
                                
			               		 echo "$vname selected"

				elif [[ $vname == "Suspend domain" ]]
                                        then
                                                echo "$vname selected"
				
				elif [[ $vname == "Resume domain" ]]
                                        then
                                                echo "$vname selected"
				
				elif [[ $vname == "List all enable domains" ]]
                                        then
                                                echo "$vname selected"

				elif [[ $vname == "List all suspended domains" ]]
                                        then
                                                echo "$vname selected"

				elif [[ $vname == "exit" ]]
                                        then
                                                break
				fi
			done
	
	elif [[ $name == "DNS Operations" ]]
		then
	    		select name2 in "Add domain"  "Delete domain"  "List all domains"
           		do
				if [[ $name2 == "Add domain" ]]
                                        then
                                                echo "$name2 selected"

                                elif [[ $name2 == "Delete domain" ]]
                                        then
                                                echo "$name2 selected"

                                elif [[ $name2 == "List all domains " ]]
                                        then
                                                echo "$name2 selected"
				fi
	   		done
	elif [[ $name == "Load balancer" ]]
       		 then
            		select name3 in "Configure nginx host"  "Add web server to lb"  "Delete web server from lb" "List all lb members"
          	 	do
                                if [[ $name3 == "add new virtual host" ]]
                                        then
                                                ./add_virtual_host_ui.sh

                                elif [[ $name3 == "Add web server to lb" ]]
                                        then
                                                ./lb/add_web_Server_ui.sh 

                                elif [[ $name3 == "Delete web server from lb " ]]
                                        then
                                                ./lb/delete_virtual_host_ui.sh

				elif [[ $name3 == "List all lb members " ]]
                                        then
                                                echo "$name3 selected"

                                fi

			done	
	
	elif [[ $name == "Configure a Web Server" ]]
                 then
                        echo "$name3 selected"
	
	elif [[ $name == "Configure NFS" ]]
                 then
                        select name4 in "Add Web server to permit list"  "Remove web server from permit list"  "List all web servers in permit list"
                        do
				 if [[ $name4 == "Add Web server to permit list" ]]
                                        then
                                                echo "$name4 selected"

                                elif [[ $name4 == "Remove web server from permit list " ]]
                                        then
                                                echo "$name4 selected"

                                elif [[ $name4 == "List all web servers in permit list " ]]
                                        then
                                                echo "$name4 selected"

                                fi

                        done

	
	elif [[ $name == "exit" ]]
                 then
			echo "hello"

	fi
done 
