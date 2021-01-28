#!/bin/sh
while IFS= read -r line; do
    ./prime-probe-executor.sh $line
    wait $1

done < $1

