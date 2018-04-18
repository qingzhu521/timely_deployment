#!/bin/sh
#
# ----------------------------------------
# Install rust for all workers
# ----------------------------------------

usage()
{
    echo "Usage: rustinstall [file of workers's ip]"
}

HOSTFILE=conf/hosts
for h in $(<$HOSTFILE); 
do
    ssh $h "curl https://sh.rustup.rs -sSf | sh"
done
