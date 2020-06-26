#!/bin/bash
# script para generar certificados letsencrypt (certbot)--->https://github.com/wmnnd/nginx-certbot
#
# TEST SCRIPT ONLY CREATES DUMMY CERTIFICATES

echo "setting environment variables"
set -a
. ./.env
set +a

echo "                                    "


doms=( DOMAIN_KIBANA DOMAIN_JUPYTER DOMAIN_ELASTIC )
data_path=${CERTBOT_PATH}
email=${email}

export IFS=";"

for d in "${doms[@]}"; do
    echo ${d}
    echo ${email}
    echo ${data_path}
    ./init-letsencrypt_params.sh -d $d -p $data_path -e $email
done