#!/bin/sh

cd api
COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f docker-compose.build.yml build
cd ..

cd  web
docker-compose -f docker-compose.build.yml build
cd ..

