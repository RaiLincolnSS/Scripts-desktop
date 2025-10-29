#!/bin/bash 


NODE_ID=$1 
OC_ID=$2

if [ -z $OCID and -z $NODE_ID ]; 
then
    echo "Favor informar o OCID e o NODE_ID"
    exit 1
fi


oci psql db-system restart-db-instance-in --db-instance-id $NODE_ID --db-system-id $OC_ID --restart-type NORMAL --profile Jetsales