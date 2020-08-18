<<<<<<< HEAD
#!/usr/bin/bash

webapps=${pwd}

domain=$1
if [ ! $domain ];then
    echo Usage: fix_domain.sh <domain>
    exit
fi


if [ -f $webapps/api/config/application.yml ];then
	#sed "s/file-host:http://[\w\.]+\//file-host: http://$domain/attachment/" $webapps/config/application.yml
	#echo $teststring | sed "s/http:\/\/[a-zA-Z\.]*\/attachment/http:\/\/$domain\/attachment/" 
	sed "s/http:\/\/[a-zA-Z\.]*\/attachment/http:\/\/$domain\/attachment/" $webapps/api/config/application.yml
else echo application.yml of api not found!
fi

if [ -f $webapps/nginx-gateway/conf.d/80.conf ];then
	sed "s/server_name  localhost/server_name  $domain/" $webapps/nginx-gateway/conf.d/80.conf
else echo 80.conf of nginx-gateway not found!
fi

if [ -f $webapps/nginx-gateway/conf.d/443.conf ];then
	sed "s/server_name localhost/server_name  $domain/" $webapps/nginx-gateway/conf.d/443.conf
else echo 443.conf of nginx-gateway not found!
fi

if [ -f $webapps/web/dist/config.js ];then
	sed "s/HOST: 'http:\/\/localhost'/HOST: 'http:\/\/$domain'/" $webapps/web/dist/config.js
else echo config.js of web not found!
fi


=======
#!/usr/bin/bash

webapps=${pwd}

domain=$1
if [ ! $domain ];then
    echo Usage: fix_domain.sh <domain>
    exit
fi


if [ -f $webapps/api/config/application.yml ];then
	#sed "s/file-host:http://[\w\.]+\//file-host: http://$domain/attachment/" $webapps/config/application.yml
	#echo $teststring | sed "s/http:\/\/[a-zA-Z\.]*\/attachment/http:\/\/$domain\/attachment/" 
	sed "s/http:\/\/[a-zA-Z\.]*\/attachment/http:\/\/$domain\/attachment/" $webapps/api/config/application.yml
else echo application.yml of api not found!
fi

if [ -f $webapps/nginx-gateway/conf.d/80.conf ];then
	sed "s/server_name  localhost/server_name  $domain/" $webapps/nginx-gateway/conf.d/80.conf
else echo 80.conf of nginx-gateway not found!
fi

if [ -f $webapps/nginx-gateway/conf.d/443.conf ];then
	sed "s/server_name localhost/server_name  $domain/" $webapps/nginx-gateway/conf.d/443.conf
else echo 443.conf of nginx-gateway not found!
fi

if [ -f $webapps/web/dist/config.js ];then
	sed "s/HOST: 'http:\/\/localhost'/HOST: 'http:\/\/$domain'/" $webapps/web/dist/config.js
else echo config.js of web not found!
fi


>>>>>>> origin/master
