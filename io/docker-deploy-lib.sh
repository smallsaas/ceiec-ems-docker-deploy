#!/bin/sh

##
#docker-compose.yml
#environment:
#   DL_STANDALONE: "am-pack-1.0.0-standalone.jar"
## 
#export DL_STANDALONE=am-pack-1.0.0-standalone.jar


#docker_tool=am-api
#docker_api=am-api


if [ ! $docker_tool ];then
  echo deploy docker name of image allin-web:jdk11 not defined
  exit
fi

if [ ! $docker_api ];then
   echo target docker name for app api a.k.a. app-openjre11 not defined
   exit
fi


## deploy
docker exec $docker_tool sh /usr/local/bin/deploy-lib.sh

echo ""
echo "## run below line to restart docker if deploying lib is successful .."
echo "docker-compose -f ../docker-compose.yml restart $docker_api"
#docker-compose -f ../docker-compose.yml restart $docker_api

