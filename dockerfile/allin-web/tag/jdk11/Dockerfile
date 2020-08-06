FROM openjdk:11.0.7-jdk
MAINTAINER craftperson/kequandian.net

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get -y install nginx

## install nodejs_11
## 
#RUN apt-get -y install apt-utils curl gnupg
#RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
#RUN apt-get -y install nodejs
## end nodejs installation

RUN apt-get install -y vim curl net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/local/openjdk-11/bin/jar /usr/bin/jar

## app config
RUN mkdir /webapps
WORKDIR   /webapps

COPY ./config/logback-spring.xml /tmp
COPY ./config/produce.yml /tmp
COPY ./config/greenfield.yml /tmp
COPY ./script/run.sh /usr/local/bin
COPY ./script/fix_url.sh /usr/local/bin
COPY ./script/fix_endpoint.sh /usr/local/bin
#deploy
COPY ./script/deploy-lib.sh /usr/local/bin
COPY ./script/deploy.sh /usr/local/bin
COPY ./script/predeploy.sh /usr/local/bin
#COPY ./script/service.sh /usr/local/bin
COPY ./script/docker-deploy-lib.sh /tmp

## start mysqld service, run app and start up nginx in run.sh 
CMD sh /usr/local/bin/run.sh
