#!/bin/bash

domain=$1
vhostsdir='/etc/httpd/conf.d/vhosts'
vhostconfFP=$vhostsdir/ssl.$domain.sus

#check if the user didnot write the domain name 
while [ "$domain" == "" ]
do
        echo -e "Please provide domain. e.g.dev,staging"
        read domain
done


# check if domain already exists
if ! [ -e $vhostconfFP ]; then
           echo -e $"This domain does not exist.\nPlease try another one"
           exit; 

mv -- "$vhostconfFP" "${vhostconfFP%.sus}.conf"

