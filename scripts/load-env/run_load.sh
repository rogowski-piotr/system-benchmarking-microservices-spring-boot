#!/bin/bash


helpFunction()
{
    echo ""
    echo "Usage: $0 [-h <string> (required)]"
    echo -e "\t-f Host IP address"
    exit 1
}


while getopts "h::" opt
do
    case "$opt" in
        h ) host="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done


if [ -z "$host" ]
then
    echo "Host parameter is empty";
    helpFunction
fi


echo $host
echo $(dirname $0)