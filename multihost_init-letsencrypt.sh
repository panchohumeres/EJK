#!/bin/bash
# script para generar certificados letsencrypt (certbot)--->https://github.com/wmnnd/nginx-certbot
#

while getopts d:p:e:m option
do 
 case "${option}" 
 in 
 d) domains=(${OPTARG});; 
 p) data_path=${OPTARG};;
 e) email=${OPTARG};;
 m) staging=${OPTARG} 
 esac 
done 


export IFS=";"

for d in $doms; do
    domains+=($d)
    ./init-letsencrypt_params.sh -d $d -p $data_path -e $email
done