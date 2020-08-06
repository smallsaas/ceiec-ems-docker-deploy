#!/bin/sh

################################
## define your var for lib deploy
#export DL_STANDALONE='alliance-api-1.0.0-standalone.jar'
#export DL_DOCKERNAME='mall-api'
################################


## main
standalone=${DL_STANDALONE}
dockername=${DL_DOCKERNAME}


if [ ! $standalone ];then
  echo DL_STANDALONE not yet defined
  exit
fi

if [ ! $dockername ];then
  echo DL_DOCKERNAME not yet defined
  exit
fi


app='app.jar'
rollback=$standalone.rollback_$(date "+%m-%d")

if [ ! -f $rollback ];then
   cp $app $rollback
   
   bash ./predeploy.sh rollback keep ${standalone}.rollback_ 6
fi

if [ -f $standalone ];then
   mv $standalone $app
fi

docker-compose restart $dockername

