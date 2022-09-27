#!/bin/bash


helpFunction()
{
    echo ""
    echo "Usage: $0 [-f <string> (required)] [-c <true|false> (optional)]"
    echo -e "\t-f Name of docker-compose file"
    echo -e "\t-h Address of load generating host"
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
    docker-compose -f $file up --build -d
    checkLastStatusFunction
}

waitForServicesFunction()
{
    echo "Waiting for services"
    pip install -r scripts/service_availability_checker/requirements.txt
    python3 scripts/service_availability_checker/service_availability_checker.py \
        --host localhost \
        --port 8080 \
        --timeout 30 \
        --health_endpoint /api/places/0
    checkLastStatusFunction
}

# TODO: connection via ssh to trigger load
benchmarkFunction()
{
    echo "Benchmark started! - not implemented"
    startTimestamp=$(date +%s)
    # ssh ubuntu@${load_generating_host} "bash scripts/load-env/run_load.sh ${hostname}"
    sleep 30
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
    echo "Cleaning services"
    docker-compose --file $file down

    echo "Cleaning prometheus metrics - not implemented!!!"
    # TODO: connection via ssh to trigger cleaning prometheus metrics
    # docker-compose \
    #     --file infrastructure/monitoring/docker-compose-monitoring.yml up \
    #     --build \
    #     --force-recreate \
    #     --no-deps \
    #     --detach \
    #     prometheus
}


while getopts "f:h:" opt
do
    case "$opt" in
        f ) file="$OPTARG" ;;
        h ) load_generating_host="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done

if [ -z "$file" ] || [ -z "$load_generating_host" ]
then
    echo "Some or all of the parameters are empty";
    helpFunction
fi

echo "$file"
echo "$load_generating_host"

setupFunction

waitForServicesFunction

benchmarkFunction

collectDataFunction

cleanFunction

echo "Benchmark finished!"
exit 0