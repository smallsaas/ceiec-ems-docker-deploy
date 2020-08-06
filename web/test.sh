#!/bin/sh

docker_api=am-web
host=http://cloud.ceiec.com

echo "更改Host"


cd dist
 sed -i 's#HOST: \x27\x27#HOST: \x27'$host'\x27#g' config.js
cd ..
echo "更改Host完成"
echo "开始重新部署项目"
 docker-compose -f ../docker-compose.yml restart $docker_api
 
 mv dist dist_bak_$(date "+%Y-%m-%d_%H-%M-%S")
echo "更改文件夹名称完成"
