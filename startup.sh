#!/bin/sh
COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up --detach --build --remove-orphans
