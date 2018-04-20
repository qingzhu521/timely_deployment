#!/bin/bash

PROJECTHOME=~/timedf
HOSTFILE=conf/hosts

i=0
BIN=$1
NUM_HOSTS=$2

PYCHOSSER=`which python`
if [ -z "$PYCHOSSER" ]; then
    PYCHOSSER=`which python3`
    if [ -z "$PYCHOSSER" ]; then
        echo "No Proper Python"
    fi
fi
host_list=$($PYCHOSSER hostHelper.py)

for h in ${host_list}; do
    echo "${h} pkill ${BIN}"
    ssh ${h} "pkill ${BIN}"
    i=$(( $i + 1))
    if [ "$i" -eq "${NUM_HOSTS}" ]; then
        break;
    fi
done


