#!/bin/bash


JMETER_PATH="infrastructure/ansible/apache-jmeter-5.5/bin/jmeter.sh"
JMETER_TEST_PLAN_PATH="infrastructure/JMeterAPITestPlan.jmx"
JMETER_OUTPUT_PATH="jmeter_output"


helpFunction()
{
    echo ""
    echo "Usage: $0 [-h <string> (required)]"
    echo -e "\t-h Host IP address"
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


${JMETER_PATH} -n -t ${JMETER_TEST_PLAN_PATH} -l ${JMETER_OUTPUT_PATH}