#!/bin/bash


helpFunction()
{
    echo ""
    echo "Usage: $0 [-f <string> (required)]"
    echo -e "\t-f Name of services docker-compose file"
    exit 1
}

checkLastStatusFunction()
{
    status=$?
    if [ $status -ne 0 ]; then
        echo "Error"
        exit $status
    fi
}

setupFunction()
{
    echo "Building docker"
    docker-compose -f $FILE up --build -d
    checkLastStatusFunction
}

waitForServicesFunction()
{
    echo "Waiting for services"
    sleep 10
}

collectDataFunction()
{
    echo "Collecting data from prometheus"
    mkdir ./output
    mkdir ./output/$FILE

    containers=$(docker ps --format {{.Names}})

    for container_name in $containers; do
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_cpu_usage_seconds_total{name=\"$container_name\"}[5m])*100&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/${container_name}_percentage_cpu_usage_seconds_total.json
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_memory_usage_bytes{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/${container_name}_memory_usage_bytes.json
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_network_receive_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/${container_name}_network_receive_bytes_total.json
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_network_transmit_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/${container_name}_network_transmit_bytes_total.json
    done

    curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=sum(rate(container_cpu_user_seconds_total{image!=\"\"}[5m])*100)&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/sum_percentage_cpu_usage_seconds_total.json
    curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=sum(container_memory_usage_bytes{image!=\"\"})/1024/1024&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/sum_memory_usage_bytes.json

    mv jmeter_output output/${FILE}/
}

cleanFunction()
{
    echo "Cleaning services"
    docker-compose --file $FILE down
    checkLastStatusFunction

    echo "Cleaning prometheus metrics"
    docker-compose \
        --file infrastructure/monitoring/docker-compose-monitoring.yml up \
        --build \
        --force-recreate \
        --no-deps \
        --detach \
        prometheus
    checkLastStatusFunction
}


while getopts "f::" opt
do
    case "$opt" in
        f ) FILE="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done

if [ -z "$FILE" ]; then
    echo "File parameter is empty";
    helpFunction
elif [ ! -f $FILE ]; then
    echo "File not exists!"
    helpFunction
fi


source $(dirname $0)/setup_local_monitoring.sh

setupFunction

waitForServicesFunction

startTimestamp=$(date +%s)
source $(dirname $0)/../load-env/run_load.sh
finishTimestamp=$(date +%s)

collectDataFunction

cleanFunction