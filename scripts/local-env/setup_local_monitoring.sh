#!/bin/bash

PROMETHEUS_CONFIG_PLACEHOLDER="CADVISOR_HOST_PLACEHOLDER"
PROMETHEUS_CONFIG_PATH="infrastructure/monitoring/prometheus.yml"

JMETER_CONFIG_PLACEHOLDER="BENCHMARK_HOST_PLACEHOLDER"
JMETER_CONFIG_PATH="infrastructure/jmeter/JMeterAPITestPlan.jmx"

DOCKER_COMPOSE_MONITORING_FILE="infrastructure/monitoring/docker-compose-monitoring.yml"
DOCKER_COMPOSE_CADVISOR_FILE="infrastructure/monitoring/docker-compose-cadvisor.yml"

sed -i "s/${PROMETHEUS_CONFIG_PLACEHOLDER}/cadvisor/g" $PROMETHEUS_CONFIG_PATH

sed -i "s/${JMETER_CONFIG_PLACEHOLDER}/localhost/g" $JMETER_CONFIG_PATH

docker-compose \
        --file $DOCKER_COMPOSE_CADVISOR_FILE up \
        --build \
		--detach

docker-compose \
        --file $DOCKER_COMPOSE_MONITORING_FILE up \
		--build \
		--detach