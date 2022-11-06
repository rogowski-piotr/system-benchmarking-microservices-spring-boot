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

waitForServicesFunction()
{
    echo "Waiting for services"
    sleep 10
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

source $(dirname $0)/../setup_services.sh -f $FILE

waitForServicesFunction

echo $(date +%s) > start_timestamp

source $(dirname $0)/../start_jmeter.sh

echo $(date +%s) > finish_timestamp

echo $(docker ps --format {{.Names}}) > containers_under_test

source $(dirname $0)/../collect_results.sh -f $FILE -l localhost

cleanFunction