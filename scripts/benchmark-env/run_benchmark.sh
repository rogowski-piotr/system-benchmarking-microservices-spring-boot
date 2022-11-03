#!/bin/bash

helpFunction()
{
    echo ""
    echo "Usage: $0 [-f <string> (required)] [-l <string> (required)] [-b <string> (required)]"
    echo -e "\t-f Name of docker-compose file"
    echo -e "\t-l Public address of load generating host"
    echo -e "\t-b Public address of benchmark host"
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

benchmarkFunction()
{
    echo "Benchmark started"
    startTimestamp=$(date +%s)
    ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null \
        -i "./.ssh/admin.pem" ubuntu@${load_generating_host} "bash scripts/load-env/run_load.sh ${benchmark_host}"
    finishTimestamp=$(date +%s)
}

collectDataFunction()
{
    echo "Collecting data from prometheus"
    mkdir ./output
    mkdir ./output/$file

    containers=$(docker ps --format {{.Names}})

    for container_name in $containers; do
        curl --location -g --request GET "http://${load_generating_host}:9090/api/v1/query_range?query=rate(container_cpu_usage_seconds_total{name=\"$container_name\"}[5m])*100&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_percentage_cpu_usage_seconds_total.json
        curl --location -g --request GET "http://${load_generating_host}:9090/api/v1/query_range?query=rate(container_memory_usage_bytes{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_memory_usage_bytes.json
        curl --location -g --request GET "http://${load_generating_host}:9090/api/v1/query_range?query=rate(container_network_receive_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_network_receive_bytes_total.json
        curl --location -g --request GET "http://${load_generating_host}:9090/api/v1/query_range?query=rate(container_network_transmit_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/${container_name}_network_transmit_bytes_total.json
    done

    curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=sum(rate(container_cpu_user_seconds_total{image!=\"\"}[5m])*100)&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/sum_percentage_cpu_usage_seconds_total.json
    curl --location -g --request GET "http://localhost:9090/api/v1/query_range?query=sum(container_memory_usage_bytes{image!=\"\"})/1024/1024&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${file}/sum_memory_usage_bytes.json

    echo "Collecting data from JMeter"
    local JMETER_OUTPUT_PATH="jmeter_output"
    scp -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null \
        -i "./.ssh/admin.pem" ubuntu@${load_generating_host}:${JMETER_OUTPUT_PATH} output/${file}/jmeter_output
}

cleanFunction()
{
    echo "Cleaning services"
    docker-compose --file $file down
    checkLastStatusFunction

    echo "Cleaning prometheus metrics"
    ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null \
        -i "./.ssh/admin.pem" ubuntu@${load_generating_host} \
        "docker-compose \
            --file infrastructure/monitoring/docker-compose-monitoring.yml up \
            --build \
            --force-recreate \
            --no-deps \
            --detach \
            prometheus"
    checkLastStatusFunction
}


while getopts ":f:l:b:" opt
do
    case "$opt" in
        f ) file="$OPTARG" ;;
        l ) load_generating_host="$OPTARG" ;;
        b ) benchmark_host="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done

if [ -z "$file" ] || [ -z "$load_generating_host" ] || [ -z "$benchmark_host" ]
then
    echo "Some or all of the parameters are empty";
    helpFunction
fi

setupFunction

waitForServicesFunction

benchmarkFunction

collectDataFunction

cleanFunction

echo "Benchmark finished!"
exit 0
