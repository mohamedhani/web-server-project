#!/bin/bash

#parameters

domain=$1
delhostdir=$2
vhostsdir='/etc/httpd/conf.d/vhosts'
certdir='/etc/httpd/conf.d/certificate/'
apachedir='/var/www/'
vhostconfFP=$vhostsdir/ssl.$domain.conf
hostdir=$apachedir$domain

# check if the user is root or not.
if [ "$(whoami)" != 'root' ]; then
        echo $"You have no permission to run $0 as non-root user. Use sudo"
                exit 1;
fi

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
else
           # Delete domain in /etc/hosts
           newhost=${domain//./\\.}
           sed -i "/$newhost/d" /etc/hosts

           # delete virtual host configuration
           rm -f $vhostconfFP
           rm -f $certdir$domain.crt
           rm -f $certdir$domain.key
           rm -f /var/log/httpd/$domain-access.log
           rm -f /var/log/httpd/$domain-error.log
           # restart Apache
           systemctl restart httpd

fi

# check if vhost directory exists or not

if [ -d $hostdir ]; then                
	#check user choice to delete hostdir or not
        if [ "$delhostdir" == 'dellhostdir' ]; then

              # Delete the directory
              rm -rf $hostdir
              echo -e $"Directory deleted"

        else
              echo -e $"Host directory conserved"
        fi
else
        echo -e $"Host directory already not found"
fi

# the final message
echo -e $"Complete!\n successfully removed Virtual Host $domain"
exit 0;


