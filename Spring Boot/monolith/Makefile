IMAGE_NAME=monolith
CONTAINER_NAME=monolith

ifeq ($(MVN),)
    MVN  := mvn
endif

.PHONY: help test build run
.DEFAULT_GOAL := build_run

help:
	@echo "Makefile commands:"
	@echo "test"
	@echo "build"
	@echo "run"

test:
	@ $(MVN) test

build:
	@ $(MVN) clean package -Dmaven.test.skip=true
	@docker build -t ${IMAGE_NAME} .

run:
	@docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}

build_run: build run