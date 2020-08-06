FROM ubuntu:16.04 
MAINTAINER craftperson/kequandian.net

RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
	apt-get -y install mysql-server-5.7 && \
	mkdir -p /var/lib/mysql && \
	mkdir -p /var/run/mysqld && \
	mkdir -p /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/log/mysql
RUN apt-get -y install openjdk-8-jdk \
    && apt-get -y install nginx
## install nodejs_11
RUN apt-get -y install gnupg
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs
## end nodejs installation
## install redis
RUN apt-get -y install redis-server
RUN apt-get install -y curl vim wget net-tools \
    && rm -rf /var/lib/apt/lists/*

# UTF-8 and bind-address
RUN sed -i -e "$ a [client]\n\n[mysql]\n\n[mysqld]"  /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysqld\]\)/\1\ninit_connect='SET NAMES utf8'\ncharacter-set-server = utf8\ncollation-server=utf8_unicode_ci\nbind-address = 127.0.0.1/g" /etc/mysql/my.cnf

VOLUME /var/lib/mysql

COPY ./startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

## app config
RUN mkdir /webapps 
WORKDIR   /webapps

RUN mkdir -p /var/www/html/swagger/app
ADD ./swagger /var/www/html/swagger

COPY ./run.sh /usr/local/bin
COPY ./config/logback-spring.xml /tmp
COPY ./config/produce.yml /tmp
COPY ./config/greenfield.yml /tmp
COPY ./service.sh /usr/local/bin

## startup mysql password
ENTRYPOINT ["/root/startup.sh"]
## start mysqld service, run app and start up nginx in run.sh 
CMD sh /usr/local/bin/run.sh

