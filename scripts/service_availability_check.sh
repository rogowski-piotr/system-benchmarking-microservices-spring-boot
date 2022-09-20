#!/bin/bash

host="$1"
port="$2"
counter=30

while [ $counter -ge 0 ]
do
  nc -z "${host}" "${port}" > /dev/null 2>&1
  result=$?

  if [[ "$result" -eq 0 ]]; then
    echo "Connection OK"
    exit $result
  else
    echo "Connection DOWN - retrying, ${counter} attempt left"
  fi

  let "counter-=1"
  sleep 1
done

echo "Connection Error"
exit 1