PROJECT_HOME=`pwd`
PYCHOSSER=`which python`
if [ -z "$PYCHOSSER" ]; then
    PYCHOSSER=`which python3`
    if [ -z "$PYCHOSSER" ]; then
        echo "No Proper Python"
    fi
fi
host_list=$($PYCHOSSER hostHelper.py)


for h in $host_list; do
    scp $h:${PROJECT_HOME}/logs/* ./logs/ 
done