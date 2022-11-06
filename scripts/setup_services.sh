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


echo "Building services"
docker-compose \
    --file $FILE up \
    --build \
    --detach
checkLastStatusFunction