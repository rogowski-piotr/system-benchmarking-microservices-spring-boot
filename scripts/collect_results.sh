#!/bin/bash


helpFunction()
{
    echo ""
    echo "Usage: $0 [-f <string> (required)] [-l <string> (required)]"
    echo -e "\t-f Name of docker-compose file"
    echo -e "\t-l Public address of load generating host"
    exit 1
}


while getopts ":f:l:" opt
do
    case "$opt" in
        f ) FILE="$OPTARG" ;;
        l ) LOAD_GENERATING_HOST="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done

if [ -z "$FILE" ] || [ -z "$LOAD_GENERATING_HOST" ]
then
    echo "Some or all of the parameters are empty";
    helpFunction
fi


containers=$(<containers_under_test)
startTimestamp=$(<start_timestamp)
finishTimestamp=$(<finish_timestamp)

if [ -z "$containers" ] || [ -z "$startTimestamp" ] || [ -z "$finishTimestamp" ]
then
    echo "Can not read some or all of the parameters from files";
fi


mkdir ./output
mkdir ./output/$FILE


echo "Collecting data from prometheus"
for container_name in $containers; do
    base_path="output/${FILE}/${container_name}"
    curl --location -g --request GET "http://${LOAD_GENERATING_HOST}:9090/api/v1/query_range?query=rate(container_cpu_usage_seconds_total{name=\"$container_name\"}[5m])*100&start=$startTimestamp&end=$finishTimestamp&step=5s" > ${base_path}_percentage_cpu_usage_seconds_total.json
    curl --location -g --request GET "http://${LOAD_GENERATING_HOST}:9090/api/v1/query_range?query=rate(container_memory_usage_bytes{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > ${base_path}_memory_usage_bytes.json
    curl --location -g --request GET "http://${LOAD_GENERATING_HOST}:9090/api/v1/query_range?query=rate(container_network_receive_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > ${base_path}_network_receive_bytes_total.json
    curl --location -g --request GET "http://${LOAD_GENERATING_HOST}:9090/api/v1/query_range?query=rate(container_network_transmit_bytes_total{name=\"$container_name\"}[5m])&start=$startTimestamp&end=$finishTimestamp&step=5s" > ${base_path}_network_transmit_bytes_total.json
done

curl --location -g --request GET "http://${LOAD_GENERATING_HOST}:9090/api/v1/query_range?query=sum(rate(container_cpu_user_seconds_total{image!=\"\"}[5m])*100)&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/sum_percentage_cpu_usage_seconds_total.json
curl --location -g --request GET "http://${LOAD_GENERATING_HOST}:9090/api/v1/query_range?query=sum(container_memory_usage_bytes{image!=\"\"})/1024/1024&start=$startTimestamp&end=$finishTimestamp&step=5s" > output/${FILE}/sum_memory_usage_bytes.json


echo "Collecting data from JMeter"
JMETER_OUTPUT_PATH="jmeter_output"

if [[ "$LOAD_GENERATING_HOST" =~ ^(localhost|127.0.0.1)$ ]]
then
    mv $JMETER_OUTPUT_PATH output/${FILE}/
else
    scp -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null \
        -i "./.ssh/admin.pem" ubuntu@${LOAD_GENERATING_HOST}:${JMETER_OUTPUT_PATH} output/${FILE}/jmeter_output
fi