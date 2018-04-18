#!/bin/bash
#######################################################################################
#Program:
#   run a binary rust program in cluster using configure which is shown 
#as follow
#
#######################################################################################
USAGE="run-timely -b [Binary file] -n [Number of hosts]"

#######################################################################################
# fixed attribute
#######################################################################################
PROJECT_HOME="~/timedf"
#BINDIR=`cd "$PROJECT_HOME"; pwd`;
HOSTFILE=conf/hosts

#######################################################################################
# parameters in
#######################################################################################
parameters="$@"




while getopts "b:n:" options;do
    case $options in
        n)
            num_host=$OPTARG
            ;;
        b)
            bin=${OPTARG}
            ;;
        ?)
            ;;
    esac
done

echo "Name of binary: ${bin}"
echo "Number of Hosts: ${num_host}"


for h in $(<${HOSTFILE}); do
    ssh ${h} "mkdir -p ${PROJECT_HOME}/conf" && \
    scp $HOSTFILE ${h}:${PROJECT_HOME}/conf/ && \
    scp $bin ${h}:${PROJECT_HOME}/ && \
    ssh ${h} "chmod 774 ${PROJECT_HOME}/$bin"
done

program_args=`python3 paraHelper.py`
echo ${program_args}

i=0
for h in $(<${HOSTFILE}); do
    echo "${h} ${PROJECT_HOME}/$bin ${program_args} -h ${HOSTFILE} -w 1 -n ${num_host} -p $i "
    ssh ${h} "${PROJECT_HOME}/$bin ${program_args} -h ${PROJECT_HOME}/${HOSTFILE} -w 1 -n ${num_host} -p $i "
    i=$(($i+1))
    if [ "$i" -eq "${num_host}" ]; then
        break;
    fi
done
