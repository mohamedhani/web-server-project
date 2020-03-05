#!/bin/bash

# parameters

domain=$1
LISTENIP=$2
owner=$(who am i | awk '{print $1}')
vhostsdir='/etc/httpd/conf.d/vhosts'
apachedir='/var/www/'
vhostsconfFP=$vhostsdir/ssl.$domain.conf
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
if [ -e $vhostsconfFP ]; then
        echo -e $"This domain already exists.\nPlease Try Another one"
        exit;
fi

#
while [ "$domain" == "" ]
do
        echo -e "Please provide domain. e.g.dev,staging"
        read domain
done

# check if the listening ip is available on this host
hostname -I > availableip.txt 
if ! grep -q $LISTENIP "availableip.txt" 
then
    echo "this ip isn't available, choose another ip"
    exit 1;
fi


# check if directory exists or not
if ! [ -d $hostdir ]; then
        # create the directory
        mkdir $hostdir
        # give permission to host dir
        chmod 755 $hostdir
        # write test file in the new domain dir
        if ! echo $"<html><h1> welcome to $domain</h1 ></html>" > $hostdir/index.html
             then
                   echo $"ERROR: Not able to write in file $hostdir/index.html. Please check permissions"
                   exit 1;
        fi
fi

SUBJ="
C=US
O=Blah
localityName=Alexandria
commonName=$1
organizationalUnitName=$1"
#openssl  req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/keys/$2.pub -keyout /etc/nginx/keys/$2.perm -subj $(echo -n "$SUBJ" | tr "\n" "/" ) > /dev/null 2>$1

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/conf.d/certificate/$domain.key -out /etc/httpd/conf.d/certificate/$domain.crt -subj $(echo -n "$SUBJ" | tr "\n" "/" ) > /dev/null 2>$1

if ! echo -e /etc/httpd/conf.d/certificate/$domain.key; then

echo "Certificate key wasn't created !"

else

echo "Certificate key created !"

fi

if ! echo -e /etc/httpd/conf.d/certificate/$domain.crt; then

echo "Certificate wasn't created !"

else

echo "Certificate created !"

fi

# create virtual host conf file
if ! echo "
    <VirtualHost $LISTENIP:443>
            SSLEngine on
            SSLCertificateFile /etc/httpd/conf.d/certificate/$domain.crt
            SSLCertificateKeyFile /etc/httpd/conf.d/certificate/$domain.key
            ServerName $domain
            DocumentRoot $hostdir
            ErrorLog /var/log/httpd/$domain-error.log
            LogLevel error
            CustomLog /var/log/httpd/$domain-access.log combined
     </VirtualHost>
     <Directory $hostdir>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride all
            Require all granted
     </Directory>" > /etc/httpd/conf.d/vhosts/ssl.$domain.conf
then
     echo -e $"There is an ERROR creating $domain conf file"
     exit 1;
else
     echo -e $"\n virtual host config file successfully created \n"
fi

# Add domain in /etc/hosts
if ! echo "127.0.0.1    $domain" >> /etc/hosts
then
     echo $"ERROR: Not able to write in /etc/hosts"
     exit 1;
else
      echo -e $"Host added to /etc/hosts file \n"
fi

if [ "$owner" == "" ]; then
      chown -R $(whoami):$(whoami) $hostdir
else
      chown -R $owner:$owner $hostdir
fi
          
# restart Apache
systemctl restart httpd 1> /dev/null 2>&1


# the final message
echo -e $"Complete! \nNew Virtual Host are ready now \nYour new host is: https://$domain \nlocated at $hostdir"
exit 0;

