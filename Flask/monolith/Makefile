IMAGE_NAME=monolith
CONTAINER_NAME=monolith

.PHONY: help test build run
.DEFAULT_GOAL := build_run

help:
	@echo "Makefile commands:"
	@echo "test"
	@echo "build"
	@echo "run"

test:
	@echo "Not implemented"

build:
	@docker build -t ${IMAGE_NAME} .

run:
	@docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}

build_run: build run