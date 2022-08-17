#!/bin/bash


helpFunction()
{
   echo ""
   echo "Usage: $0 [-f <string> (required)] [-c <true|false> (optional)]"
   echo -e "\t-f Name of docker-compose file"
   echo -e "\t-c Clean docker system before run benchmark"
   exit 1
}

cleanFunction()
{
    echo "Cleaning..."
    docker rm -f $(docker ps -aq)
    docker system prune --all -f
}

setupFunction()
{
    echo "Building docker"
    docker-compose -f $file up --build -d
}

benchmarkFunction()
{
    echo "Benchmark started!"
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


if $clean_flag ; then
    cleanFunction
fi

setupFunction

benchmarkFunction

echo "Benchmark finished!"
exit 0