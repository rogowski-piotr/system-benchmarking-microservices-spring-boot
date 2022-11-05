#!/bin/bash


JMETER_PATH="infrastructure/ansible/apache-jmeter-5.5/bin/jmeter.sh"
JMETER_TEST_PLAN_PATH="infrastructure/JMeterAPITestPlan.jmx"
JMETER_OUTPUT_PATH="jmeter_output"

${JMETER_PATH} -n -t ${JMETER_TEST_PLAN_PATH} -l ${JMETER_OUTPUT_PATH}