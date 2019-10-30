#!/bin/sh

echo Make Directories for gitlab? [y,n]
read dir

echo Update hostname for docker compose? [y,n]
read chhost

echo Generate SSL certificate? [y,n]
read ssl

echo Install server admin tools? epel,cockpit,webmin,htop,tmux. [y,n]
read tools

echo Install docker CE? [y,n]
read dockerce

echo open firewall ports? 443,22 [y,n]
read firewall

echo run docker compose? [y,n]
read run

echo remove all setup files when finished? [y,n]
read delete 


#create the Directories
if [[ "$dir" == "y" ]] || [[ "$input" == "yes" ]]; then

#Setup presistant data directories 
mkdir -p /srv/gitlab/config
mkdir -p /srv/gitlab/logs
mkdir -p /srv/gitlab/data
mkdir -p /srv/gitlab/ssl &&

  echo Directories Created

fi

#Upade docker_compose Hostname

if [[ "$chhost" == "y" ]] || [[ "$input" == "yes" ]]; then

read -p "Hostname eg. gitlab.example.com " host

sed -i "s/gitlab.example.com/$host/g" docker-compose.yml

fi

#Make SSL cert
if [[ "$ssl" == "y" ]] || [[ "$input" == "yes" ]]; then

read -p "Country? Eg. US " country 
read -p "State? Eg. California " state
read -p "City? Eg. San Diego " city
read -p "Orginization? Eg. company " orginization
read -p "Orginizational Unit? Eg. department " orgunit  
read -p "server hostname? Cn? example.example.com " cname

sed -i "s/country/$country/g" pre_setup/ssl_gen.sh
sed -i "s/state/$state/g" pre_setup/ssl_gen.sh
sed -i "s/city/$city/g" pre_setup/ssl_gen.sh
sed -i "s/orginization/$orginization/g" pre_setup/ssl_gen.sh
sed -i "s/orgunit/$orgunit/g" pre_setup/ssl_gen.sh
sed -i "s/cname/$cname/g" pre_setup/ssl_gen.sh

sh ./pre_setup/ssl_gen.sh
  echo Docker CE installed

   echo SSL cert generated

fi


#Install the tools
if [[ "$tools" == "y" ]] || [[ "$input" == "yes" ]]; then

sh ./pre_setup/cent_inst.sh

  echo Admin Tools installed

fi


#Install docker CE
if [[ "$dockerce" == "y" ]] || [[ "$input" == "yes" ]]; then

sh ./pre_setup/cent_inst.sh

  echo Docker CE installed

fi

#Open Firewall ports
if [[ "$firewall" == "y" ]] || [[ "$input" == "yes" ]]; then

firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --zone=public --permanent --add-service=ssh
firewall-cmd --reload

echo Firewall ports added

fi

#Run docker-compose
if [[ "$run" == "y" ]] || [[ "$input" == "yes" ]]; then

docker-compose up -d

echo Docker up

fi


#Remove setup files
if [[ "$delete" == "y" ]] || [[ "$input" == "yes" ]]; then

rm -rf pre_setup jcameron-key.asc.1 jcameron-key.asc pre_setup.sh

fi

echo Done
