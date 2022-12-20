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

    echo "Cleaning some trash files"
    rm ./start_timestamp
    rm ./finish_timestamp
    rm ./containers_under_test
    rm ./JMeterAPITestPlan.jmx
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


# Setup local Docker monitoring (Grafana, Prometheus, CAdvisor)
source $(dirname $0)/setup_local_monitoring.sh
checkLastStatusFunction

# Setup services under test
source $(dirname $0)/../setup_services.sh -f $FILE
checkLastStatusFunction

# Wait until services will be available
waitForServicesFunction
checkLastStatusFunction

# Save start timestamp
echo $(date +%s) > start_timestamp
checkLastStatusFunction

# Run JMeter as Docker container
source $(dirname $0)/../run_jmeter.sh
checkLastStatusFunction

# Save finish timestamp
echo $(date +%s) > finish_timestamp
checkLastStatusFunction

# Save containers names under test
echo $(docker ps --format {{.Names}}) > containers_under_test
checkLastStatusFunction

# Collect results from CAdvisor and JMeter
source $(dirname $0)/../collect_results.sh -f $FILE -l localhost
checkLastStatusFunction

# Clean after benchmark
cleanFunction
checkLastStatusFunction

# Generate plots using R
mkdir post_processing/03_output
docker-compose -f post_processing/docker-compose.yml up
cp -r post_processing/03_output/* output/
