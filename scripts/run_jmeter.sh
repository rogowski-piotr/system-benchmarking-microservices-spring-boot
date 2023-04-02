#!/bin/bash


JMETER_COMPOSE_FILE_PATH=infrastructure/jmeter/docker-compose-jmeter.yml


docker-compose \
    --file $JMETER_COMPOSE_FILE_PATH up \
    --build

docker-compose \
    --file $JMETER_COMPOSE_FILE_PATH down