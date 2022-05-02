IMAGE_NAME=route2-service
CONTAINER_NAME=route2-service
NETWORK_NAME=app-network

ifeq ($(MVN),)
    MVN  := mvn
endif

.PHONY: help build run push build_push
.DEFAULT_GOAL := build_push

help:
	@echo "Makefile commands:"
	@echo "test"
	@echo "build"
	@echo "run"
	@echo "push"

test:
	@ $(MVN) test

.create_network:
	@docker network create ${NETWORK_NAME}

build:
	@ $(MVN) clean package -Dmaven.test.skip=true
	@docker build -t ${IMAGE_NAME} .

run:
	make .create_network --ignore-errors
	@docker run -d -p 8084:8084 --net ${NETWORK_NAME} --name ${CONTAINER_NAME} ${IMAGE_NAME}

push:
	@echo "Not implemented yet"

build_push: build push