#!/bin/sh

#Setup presistant data directories 
mkdir -p /srv/gitlab/config
mkdir -p /srv/gitlab/logs
mkdir -p /srv/gitlab/data
mkdir -p /srv/gitlab/ssl &&

echo ssl cert

echo Country? Eg. US 
read C

echo State? Eg. California
read ST

echo City? Eg. San Diego
read L

echo Company?
read O

echo Department?  
read OU

echo server hostname? example.example.com
read CN
