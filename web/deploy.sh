#!/bin/sh

docker_web=am-web

if [ ! -f dist.tar ];then
   echo dist.tar not exists
   exit
fi

if [ -d dist ];then 
  echo mv dist dist_rollback_$(date "+%Y-%m-%d_%H-%M")
  mv dist dist_rollback_$(date "+%Y-%m-%d_%H-%M")
fi

## un tar dist.tar
echo tar -xvf dist.tar
tar -xvf dist.tar 
echo rm -f dist.tar
rm -f dist.tar

#host=http://39.108.14.206:8070
#echo "更改Host"
#cd dist
# sed -i 's#HOST: \x27\x27#HOST: \x27'$host'\x27#g' config.js
#cd ..
#echo "更改Host完成"
## just copy config.js into dist
echo cp config.js dist/config.js
cp config.js dist/config.js


#echo "开始重新部署项目"
echo docker-compose -f ../docker-compose.yml restart $docker_web 
docker-compose -f ../docker-compose.yml restart $docker_web


#mv dist dist_bak_$(date "+%Y-%m-%d_%H-%M-%S")
#echo "更改文件夹名称完成"
