#!/bin/bash

#$1  listen ip 
#$2  server name 

CONF_FILE="/etc/nginx/conf.d/$2.conf"
cat << EOF > $CONF_FILE
upstream backend
{
 include /etc/nginx/conf.d/web_server_lb;
}
server 
{
    listen $1:80;
EOF

echo  'return 301 https://$host$request_uri;' >> $CONF_FILE


cat << EOF >> $CONF_FILE
}
 
server
{
 listen $1:443 ssl;
 server_name www.$2;
EOF


SUBJ="
C=US
O=Blah
localityName=Alexandria
commonName=www.$2
organizationalUnitName=$2"
openssl  req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/keys/$2.pub -keyout /etc/nginx/keys/$2.perm -subj $(echo -n "$SUBJ" | tr "\n" "/" ) > /dev/null 2>&1
if [ $? -ne 0 ] 
then 
   echo "openssl package is not istalled"
   exit  1
fi
cat << EOF  >> $CONF_FILE
 
     ssl_certificate /etc/nginx/keys/$2.pub;
     ssl_certificate_key /etc/nginx/keys/$2.perm;
EOF
 


cat << EOF >> $CONF_FILE
 location = /
  {
     proxy_pass  https://backend;
  }


 access_log /var/log/nginx/$2.log;
 error_log /var/log/nginx/$2-error.log;

}
EOF

exit 0



















