#!/bin/bash

set -a
. ./.env
set +a

echo "creating certs dir: "${HOST_DATA_PATH}"/certs"
mkdir ${HOST_DATA_PATH}/certs
echo "creating certbot dir"
mkdir ${CERTBOT_PATH}
echo "changing ownership of certbot dir (for docker execution)"
sudo chmod -R g+rwx ${CERTBOT_PATH}
sudo chgrp -R ${UID} ${CERTBOT_PATH}
sudo chown -R ${UID} ${CERTBOT_PATH}

var=${1:-nada} #DEFAULT ARGUMENT "NADA"-->NOTHING

#THIS LOOPS THROUGH CLI ARGUMENTS IN CASE THEY EXIST
#if "elastic" not in arguments, do not run TSL Internal layer certificates code
if [ "$var" == "nada" ]; then 
    #CREATE CERTIFICATES FOR INTERNAL ELASTICSEARCH-KIBANA COMMUNICATION (TSL LAYER)
    echo "creating certificates for TSL internal layer of stack"
    docker-compose -f ./certs/create-certs.yml run --rm create_certs
else
    el=0
    args=() #create array of domains
    for a in "$@" #loop through the array of domains
    do
        a=${a#*-} #remove "-" prefix from CLI argument
        if [[ "${a^^}" == "ELASTIC"  ]]; then
            #CREATE CERTIFICATES FOR INTERNAL ELASTICSEARCH-KIBANA COMMUNICATION (TSL LAYER)
            echo "creating certificates for TSL internal layer of stack"
            #docker-compose -f ./certs/create-certs.yml run --rm create_certs
            el+=1
        fi

    done

    if [ $el == 0 ]; then
        echo "'elastic' or 'ELASTIC' not in the arguments, not creating certificates for TSL internal layer of stack"
    fi
fi

echo "changing ownership of certificates files (for docker execution)"

echo "creating ETLcache dir"
mkdir ${CERTBOT_PATH}/ETLcache
echo "changing ownership of ETLcache dirs (for docker execution)"

sudo chmod -R g+rwx ${HOST_DATA_PATH}
sudo chgrp -R ${UID} ${HOST_DATA_PATH}
sudo chown -R ${UID} ${HOST_DATA_PATH}

