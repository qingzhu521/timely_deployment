#!/bin/bash
#######################################################################################
#Program:
#   run a binary rust program in cluster using configure which is shown 
#as follow
#
#######################################################################################
USAGE="run-timely -b [Binary file] -n [Number of hosts] [-d option]"
Usage(){
    echo USAGE
}
#######################################################################################
# fixed attribute
#######################################################################################
PROJECT_HOME=`pwd`
#BINDIR=`cd "$PROJECT_HOME"; pwd`;
HOSTFILE=conf/hosts

#######################################################################################
# parameters in
#######################################################################################
parameters="$@"


distribution="FALSE"

while getopts "b:n:d" options;do
    case $options in
        n)
            num_host=$OPTARG
            ;;
        b)
            bin=${OPTARG}
            ;;
        d)
            distribution="TRUE"
            ;;
        ?)
            ;;
    esac
done

if [ -z "${num_host}" -o -z "${bin}" ]; then
    Usage
    exit 1
fi

echo "Name of binary: ${bin}"
echo "Number of Hosts: ${num_host}"

#######################################################################################
#  python chooser
#######################################################################################
PYCHOSSER=`which python`
if [ -z "$PYCHOSSER" ]; then
    PYCHOSSER=`which python3`
    if [ -z "$PYCHOSSER" ]; then
        echo "No Proper Python"
    fi
fi


host_list=$($PYCHOSSER hostHelper.py)

if [ "$distribution" == "TRUE" ]; then
    echo "distributing "
    for h in ${host_list}; do
        if [ -z "$h" ]; then
            break;
        fi
        echo "$h start to processing"
        ssh ${h} "mkdir -p ${PROJECT_HOME}/conf" && \
        ssh ${h} "mkdir -p ${PROJECT_HOME}/logs" && \
        scp $HOSTFILE ${h}:${PROJECT_HOME}/conf/ && \
        scp $bin ${h}:${PROJECT_HOME}/ && \
        ssh ${h} "chmod 774 ${PROJECT_HOME}/$bin"
    done
fi

program_args=`$PYCHOSSER paraHelper.py`
echo ${program_args}

if [ -z "${bin}" -o -z "${num_host}" ]; then
    Usage
    exit 1
fi


i=0
for h in ${host_list}; do
    echo "${h} ${PROJECT_HOME}/$bin ${program_args} -h ${HOSTFILE} -n ${num_host} -p $i "
    ssh ${h} "${PROJECT_HOME}/$bin ${program_args} -h ${PROJECT_HOME}/${HOSTFILE} -n ${num_host} -p $i >> ${PROJECT_HOME}/logs/$bin.log 2>${PROJECT_HOME}/logs/$bin.err" &
    i=$(($i+1))
    if [ "$i" -eq "${num_host}" ]; then
        break;
    fi
done

wait
echo "Completed, wait 5s for safe termination"
sleep 5
./kill-timely.sh ${bin} ${num_host}