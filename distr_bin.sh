###########################################################
#  Usage
#   
#
###########################################################

Usage(){
    echo "to every worker"
}

ROJECT_HOME=~/timedf/
HOSTFILE=conf/hosts
BIN=$2

for h in $(<$HOSTFILE);
do
    ssh ${h} "mkdir -p $PROJECT_HOME/conf" && \
    scp $HOSTFILE $h:$PROJECT_HOME/conf && \
    scp $BIN $h:$PROJECT_HOME && \
    ssh $h "chmod 744 $PROJECT_HOME/$BIN"
done