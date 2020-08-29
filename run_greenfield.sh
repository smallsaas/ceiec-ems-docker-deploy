#!/bin/sh

if [ ! -d ./nginx-gateway/attachments ];then
  mkdir ./nginx-gateway/attachments
fi

if [ ! -d ./nginx-gateway/logs ];then
  mkdir ./nginx-gateway/logs
fi

if [ ! -d ./web/logs ];then
  mkdir ./web/logs
fi


if [ ! -d ./mysql/data ];then
  mkdir ./mysql/data
fi

docker-compose -f greenfield.yml up 
