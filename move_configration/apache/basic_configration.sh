#!/bin/bash 
function local_repo_configration
{
    OUTPUT=0
cat << EOF > /etc/yum.repos.d/local.repo  
[local]
name=local repo
baseurl=file:///media/
enabled=1
gpgcheck=1
gpgkey=file:///media/RPM-GPG-KEY-*-release
EOF

    echo "please enter your cd"
   read -s -p  "then press enter" ENTER
   mount /dev/sr0 /media  > /dev/null  2>&1
   if [ $? -ne 0 ]
   then
     echo "the cd is not found"
     OUTPUT=1
   fi
   return $OUTPUT

}

