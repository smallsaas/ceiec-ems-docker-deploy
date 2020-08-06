#!/usr/bin/env bash
#spring:
#  profiles:
#    active: greenfield
#---

usage() {
   echo "Usage: service.sh <start|stop|restart|exec|reload|remove|greenfield>"
   echo '---'
   echo "  greenfield ## green field setup with initialize database"
   echo "  first setup config/application.yml as greenfield config !"
}

###############################
# custom setting
#export DOCKER_NAME=app-api
##############################


## config
cmd=$1

IMAGE='zelejs/allin-web:slim'
name=${DOCKER_NAME}
if [ ! $name ];then
   echo DOCKER_NAME is not set
   exit
fi

if [ ! $cmd ];then
   usage
   exit
fi

if [ "$cmd"x == "greenfield"x ];then
   echo '' > /dev/null
elif [  ! $name ];then
   echo "env DOCKER_NAME is not set"
   exit
fi

if [ "$cmd"x == "start"x ];then
   if [ ! $name ];then
      echo "env DOCKER_NAME is not set"
      exit
   fi
fi

if [ "$cmd"x == "start"x ];then
   docker container start $name
elif [ "$cmd"x == "restart"x ];then
   docker container restart $name
elif [ "$cmd"x == "stop"x ];then
   docker container stop $name
elif [ "$cmd"x == "exec"x ];then
   docker exec -it $name bash
elif [ "$cmd"x == "reload"x ];then
   docker container reload $name
elif [ "$cmd"x == "remove"x ];then
   docker container stop $name 
   docker container rm $name
elif [ "$cmd"x == "greenfield"x ];then
   echo '## first setup greenfield within application.yml'
   echo '## cat config/greenfield.yml >> config/application.yml'
   echo "docker exec -it $name bash"
   echo "java -jar *-standalone.jar --spring.profiles.active=greenfield"
else
   usage
fi

