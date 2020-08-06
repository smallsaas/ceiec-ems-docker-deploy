#!/bin/sh

################################
## define your var for lib deploy
#export DL_STANDALONE='alliance-api-1.0.0-standalone.jar'
#export DL_DOCKERNAME='mall-api'
################################
if [ ! -d ./lib ];then
  echo './lib dir not found !' 1>&2  ##stderr
  exit 1
elif [ -z $(ls ./lib) ];then
  echo 'no lib found under ./lib !' >/dev/stderr  ## stderr
  exit 1
fi



## main
standalone=${DL_STANDALONE}
dockername=${DL_DOCKERNAME}
app='app.jar'
keep=2
webapp='/webapps'

cd $webapp


## not defined, find it.
if [ ! $standalone ];then
   standalone=$(ls *-standalone.jar)
fi

if [ $standalone ];then
   echo mv $standalone $app
   mv $standalone $app
   echo $standalone > .standalone
elif [ -f .standalone ];then
   standalone=$(cat .standalone)
fi

if [ ! $standalone ];then
  echo 'no pattern of *-standalone.jar info found !' 1>&2
  exit 1
fi
# not mandatory
#if [ ! $dockername ];then
#  echo DL_DOCKERNAME not yet defined
#  exit
#fi

fixapp='app-fix.jar'
if [ ! -f lib/$fixapp ];then
   echo cp $app lib/$fixapp 1>&2
   cp $app lib/$fixapp
fi


## iterate lib
cd lib;pwd
num=0
for lib in $(ls);do
   num=$(($num+1))
   inf=$(jar tf $fixapp | grep $lib)
   if [ $inf ];then
     echo $inf
     inf_dir=$(dirname $inf)
     if [ ! -d $inf_dir ];then
        mkdir -p $inf_dir
     fi
     echo mv $lib $inf_dir 1>&2
     mv $lib $inf_dir
   fi
done

##
if [ $num -eq 0 ];then
   echo 'no lib to deploy !' 1>&2
   exit 1
fi


## prepare done
## start deploy lib

if [ -d BOOT-INF ];then
 for lib in $(ls BOOT-INF/lib);do
   inf=$(jar tf $fixapp | grep $lib)
   if [ $inf ];then
      echo jar 0uf $fixapp $inf
      jar 0uf $fixapp $inf
   fi
 done
fi
## working dir
cd ..;pwd
#pwd


## rollback
rollback_issue=${standalone}.rollback_$(date "+%m-%d")
if [ -f $rollback_issue ];then
   rm -f $rollback_issue
fi
if [ -f $app ];then
   echo mv $app $rollback_issue
   mv $app $rollback_issue

   # Usage: predeploy.sh rollback keep <pattern> <num>
   if [ -f /usr/local/bin/predeploy.sh ];then
      bash /usr/local/bin/predeploy.sh rollback keep ${standalone}.rollback_ $keep
   elif [ -f ./predeploy.sh ];then
      bash ./predeploy.sh rollback keep ${standalone}.rollback_ $keep
   fi
fi

##
#deploy
echo mv lib/$fixapp $app
mv lib/$fixapp $app

#cleanup 
echo rm -rf lib/*
rm -rf lib/*


#------
if [ $dockername ];then
  echo docker-compose -f docker-compose.yml restart $dockername
  dockercompose -f docker-compose.yml restart $dockername
  docker-compose -f docker-compose.yml restart redis
fi

echo success
