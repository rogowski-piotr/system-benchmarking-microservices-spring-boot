IMAGE_NAME=place-service
CONTAINER_NAME=place-service
NETWORK_NAME=app-network

.DEFAULT_GOAL := build_run

.create_network:
	@docker network create ${NETWORK_NAME}

build:
	@docker build -t ${IMAGE_NAME} .

run:
	make .create_network --ignore-errors
	@docker run -d -p 8081:8081 --net ${NETWORK_NAME} --name ${CONTAINER_NAME} ${IMAGE_NAME}

build_run: build run