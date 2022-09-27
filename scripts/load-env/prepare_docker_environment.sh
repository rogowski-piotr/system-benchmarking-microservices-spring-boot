#!/bin/bash


HOST_FILE="benchmark_host"
PROMETHEUS_CONFIG_PLACEHOLDER="CADVISOR_HOST_PLACEHOLDER"
PROMETHEUS_CONFIG_PATH="infrastructure/monitoring/prometheus.yml"
DOCKER_COMPOSE_MONITORING_FILE="infrastructure/monitoring/docker-compose-monitoring.yml"


helpFunction()
{
    echo ""
    echo "Usage: $0 [-h <string> (required)]"
    echo -e "\t-h Host IP address"
    exit 1
}


while getopts "h::" opt
do
    case "$opt" in
        h ) BENCHMARK_HOST="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done


if [ -z "$BENCHMARK_HOST" ]
then
    echo "Host parameter is empty";
    helpFunction
fi

echo "$BENCHMARK_HOST" > "$HOST_FILE"

sed -i "s/${PROMETHEUS_CONFIG_PLACEHOLDER}/${BENCHMARK_HOST}/g" $PROMETHEUS_CONFIG_PATH

docker-compose \
        --file $DOCKER_COMPOSE_MONITORING_FILE up \
		--build \
		--detach

