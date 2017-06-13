#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage:"
  echo "$(basename $0) <number of jobs> <duration in seconds>"
  exit 0
fi

JOBCOUNT=$1
DURATION=$2

for idx in $(eval echo {1..$JOBCOUNT}); do
  dd if=/dev/urandom | base64 | bzip2 -9 >> /dev/null &
done

echo "Spawned jobs: $(jobs -p)"
sleep $DURATION
jobs -p | xargs kill
