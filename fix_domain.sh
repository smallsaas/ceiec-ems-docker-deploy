#!/usr/bin/bash

webapps=${PWD}

domain=$1
if [ ! $domain ];then
   echo 'Usage: fix_domain.sh <domain>'
   exit
fi


if [ -f $webapps/api/config/application.yml ];then
   echo $webapps/api/config/application.yml
   #sed "s/file-host:http://[\w\.]+\//file-host: http://$domain/attachment/" $webapps/config/application.yml
   #echo $teststring | sed "s/http:\/\/[a-zA-Z\.]*\/attachment/http:\/\/$domain\/attachment/" 
   sed -i "s/http:\/\/[0-9a-zA-Z\.]*\/attachment/http:\/\/$domain\/attachment/" $webapps/api/config/application.yml
else
    echo application.yml of api not found!
fi

if [ -f $webapps/nginx-gateway/conf.d/80.conf ];then
   if ! case $domain in 192.168.*) false;; esac; then
      echo $webapps/nginx-gateway/conf.d/80.conf localhost
      sed -i "s/server_name[[:space:]]*[0-9a-zA-Z\.]*/server_name  localhost/" $webapps/nginx-gateway/conf.d/80.conf
   else
      echo $webapps/nginx-gateway/conf.d/80.conf
      sed -i "s/server_name[[:space:]]*[0-9a-zA-Z\.]*/server_name  $domain/" $webapps/nginx-gateway/conf.d/80.conf
   fi
else 
   echo 80.conf of nginx-gateway not found!
fi

# no https config
#if [ -f $webapps/nginx-gateway/conf.d/443.conf ];then
#   sed -i "s/server_name[[:space:]]*[0-9a-zA-Z\.]*/server_name  $domain/" $webapps/nginx-gateway/conf.d/443.conf
#else 
#   echo 443.conf of nginx-gateway not found!
#fi


if [ -f $webapps/web/config.js ];then
   echo $webapps/web/config.js
   sed -i "s/HOST:[[:space:]]*'http:\/\/[0-9a-zA-Z\.]*'/HOST: 'http:\/\/$domain'/" $webapps/web/config.js
   cp $webapps/web/config.js $webapps/web/dist/config.js
else 
   echo config.js of web not found!
fi


