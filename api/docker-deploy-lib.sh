#!/bin/sh

##
#docker-compose.yml
#environment:
#   DL_STANDALONE: "am-pack-1.0.0-standalone.jar"
## 
#export DL_STANDALONE=am-pack-1.0.0-standalone.jar

docker_tool=am-api
docker_api=am-api

## deploy
docker exec $docker_tool sh /usr/local/bin/deploy-lib.sh

echo ""
echo "## run below line to restart docker if deploying lib is successful .."
docker-compose -f ../docker-compose.yml restart $docker_api

