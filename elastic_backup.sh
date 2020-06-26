#!/bin/bash

echo "setting environment variables"
set -a
. ./.env
. ./ebak.env
set +a

echo "                                    "

#replace variables with default from main docker-compose .env file, y parameters are empty
if [ -z "$TARGET_ENDPOINT" ] && [ "$MODE" = "remote-local" ]; then
      TARGET_ENDPOINT=localhost:${ELASTIC_PORT}
else 
    TARGET_ENDPOINT=${DOMAIN_ELASTIC}
fi
if [ -z "$TARGET_USER" ]; then
      TARGET_USER=elastic
fi
if [ -z "$TARGET_PSWWD" ]; then
      TARGET_PSSWD=${ELASTIC_PASSWORD}
fi  

if [ -z "$SOURCE_ENDPOINT" ] && [ "$MODE" = "remote-local" ]; then
      SOURCE_ENDPOINT=${DOMAIN_ELASTIC}
else
      SOURCE_ENDPOINT=localhost:${ELASTIC_PORT}
fi
if [ -z "$SOURCE_USER" ]; then
      SOURCE_USER=elastic
fi
if [ -z "$SOURCE_PSWWD" ]; then
      SOURCE_PSSWD=${ELASTIC_PASSWORD}
fi 

echo "Source DB Params"
echo "-----------------"
echo "endpoint: "${SOURCE_ENDPOINT}
echo "index: "${SOURCE_INDEX}

echo "                                    "

echo "Target DB Params"
echo "-----------------"
echo "endpoint: "${TARGET_ENDPOINT}
echo "index: "${TARGET_INDEX}

echo "                                    "

cd ${HOST_DATA_PATH}/certs
CERTS_PATH=${PWD}
echo "HOST CERTS PATH: "${CERTS_PATH}
echo "                              "
echo "MODE: "${MODE}

if [ "$MODE" = "remote-local" ]; then

      docker run -v ${CERTS_PATH}:/tmp/certs --net=host --rm  taskrabbit/elasticsearch-dump \
            --input=https://${SOURCE_USER}:${SOURCE_PSSWD}@${SOURCE_ENDPOINT}/${SOURCE_INDEX} \
            --output=http://${TARGET_USER}:${SOURCE_PSSWD}@${TARGET_ENDPOINT}/${TARGET_INDEX} \
            --output-ca=/tmp/certs/ca/ca.crt \
            --tlsAuth \
            --type=data

elif [ "$MODE" = "local-remote" ]; then

            docker run -v ${CERTS_PATH}:/tmp/certs --net=host --rm  taskrabbit/elasticsearch-dump \
            --input=https://${SOURCE_USER}:${SOURCE_PSSWD}@${SOURCE_ENDPOINT}/${SOURCE_INDEX} \
            --input-ca=/tmp/certs/ca/ca.crt \
            --tlsAuth \
            --output=http://${TARGET_USER}:${SOURCE_PSSWD}@${TARGET_ENDPOINT}/${TARGET_INDEX} \
            --type=data