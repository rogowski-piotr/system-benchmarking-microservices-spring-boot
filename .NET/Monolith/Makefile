IMAGE_NAME=monolith:dotnet
CONTAINER_NAME=monolith-dotnet
NETWORK_NAME=app-network

.create_network:
	@docker network create ${NETWORK_NAME}

build:
	@docker build -t ${IMAGE_NAME} .

run:
	make .create_network --ignore-errors
	@docker run -d -p 8080:8080 --net ${NETWORK_NAME} --name ${CONTAINER_NAME} ${IMAGE_NAME}

build_run: build run