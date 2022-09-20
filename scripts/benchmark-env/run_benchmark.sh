#!/bin/bash


helpFunction()
{
    echo ""
    echo "Usage: $0 [-f <string> (required)] [-c <true|false> (optional)]"
    echo -e "\t-f Name of docker-compose file"
    echo -e "\t-c Clean docker containers after benchmark process"
    exit 1
}

setupFunction()
{
    echo "Building docker"
    docker-compose -f $file up --build -d
}

benchmarkFunction()
{
    echo "Benchmark started!"
    startTimestamp=$(date +%s)
    sleep 45
    finishTimestamp=$(date +%s)
}

collectDataFunction()
{
    echo "Collecting data from prometheus"
    mkdir ./output
    mkdir ./output/$file

    containers=$(docker ps --format {{.Names}})

    for container_name in $containers; do
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_cpu_usage_seconds_total{name=\"$container_name\"}[5m])*100&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_percentage_cpu_usage_seconds_total.json
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_memory_usage_bytes{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_memory_usage_bytes.json
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_network_receive_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_network_receive_bytes_total.json
        curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=rate(container_network_transmit_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_network_transmit_bytes_total.json
    done

    curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=sum(rate(container_cpu_user_seconds_total{image!=\"\"}[5m])*100)&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/sum_percentage_cpu_usage_seconds_total.json
    curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=sum(container_memory_usage_bytes{image!=\"\"})/1024/1024&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/sum_memory_usage_bytes.json
}

cleanFunction()
{
    if $clean_flag ; then
        echo "Cleaning services"
        docker-compose --file $file down

        echo "Cleaning prometheus metrics"
        docker-compose \
            --file infrastructure/monitoring/docker-compose-monitoring.yml up \
            --build \
            --force-recreate \
            --no-deps \
            --detach \
            prometheus
    fi
}


clean_flag=true

while getopts "f:c:" opt
do
    case "$opt" in
        f ) file="$OPTARG" ;;
        c ) if [ "$OPTARG" = true ] || [ "$OPTARG" = false ] ; then
                clean_flag="$OPTARG"
            else
                helpFunction
            fi
        ;;
        ? ) helpFunction ;;
    esac
done

if [ -z "$file" ]
then
    echo "Some or all of the parameters are empty";
    helpFunction
fi

setupFunction

benchmarkFunction

collectDataFunction

cleanFunction

echo "Benchmark finished!"
exit 0