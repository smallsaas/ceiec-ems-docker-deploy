#!/usr/bin/bash

dist_root=${pwd}

if [ $1 ];then
   dist_root=$1
fi

if [ -f $dist_root/api/config/application.yml ];then
   file-host=${file-host}
   echo $file-host
   if [[ $file-host == http://cloud.ceiec.com/attachments ]];then
      file-host=$endpoint
   else
      endpoint="http://cloud.ceiec.com/attachments"
   fi
fi

if [ -f $dist_root/io/config/application.yml ];then
   file-host=${file-host}
   if [[ $file-host == http://cloud.ceiec.com/attachments ]];then
      file-host=$endpoint
   else
      endpoint="http://cloud.ceiec.com/attachments"
   fi
fi