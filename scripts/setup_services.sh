#!/bin/bash


helpFunction()
{
    echo ""
    echo "Usage: $0 [-f <string> (required)] [-n <integer> (optional)]"
    echo -e "\t-f Name of services docker-compose file"
    echo -e "\t-n Number of instances to scale (microservices only)"
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

NUMBER_INSTANCES=1

while getopts "f:n:" opt
do
    case "$opt" in
        f ) FILE="$OPTARG" ;;
        n ) NUMBER_INSTANCES="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done

ARCHITECTURE=$(echo "$FILE" | sed -rn 's/^docker-compose-.+-(.+).yml$/\1/p')

if [ -z "$FILE" ]; then
    echo "File parameter is empty";
    helpFunction
elif [ ! -f $FILE ]; then
    echo "File not exists!"
    helpFunction
elif [ "$ARCHITECTURE" = "monolith" ] && [ $NUMBER_INSTANCES -gt 1 ]; then
    echo "-n parameter in not acceptable for monolith option"
    helpFunction
fi

echo "Building services"

CMD="docker-compose "
CMD+="--file $FILE up "
CMD+="--build "
CMD+="--detach "

if [ $NUMBER_INSTANCES -gt 1 ]; then
    CMD+="--scale place-service=$NUMBER_INSTANCES "
    CMD+="--scale distance-service=$NUMBER_INSTANCES "
    CMD+="--scale route1-service=$NUMBER_INSTANCES "
    CMD+="--scale route2-service=$NUMBER_INSTANCES "
fi

eval $CMD
checkLastStatusFunction