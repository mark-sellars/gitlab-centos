#!/bin/sh
#generate SSL Cert 
openssl req -days 3650 -nodes -newkey rsa:2048 -new -x509 -keyout /srv/gitlab/ssl/server-key.pem -out /srv/gitlab/ssl/server-cert.pem -subj '/C=C/ST=ST/L=L/O=O/OU=OU/CN=CN'

