#!/bin/bash
# script para generar certificados letsencrypt (certbot)--->https://github.com/wmnnd/nginx-certbot
#
# TEST SCRIPT ONLY CREATES DUMMY CERTIFICATES

while getopts d:p:e: option
do 
 case "${option}" 
 in 
 d) doms=(${OPTARG});; 
 p) data_path=${OPTARG};;
 e) email=${OPTARG};;
 m) staging=${OPTARG} 
 esac 
done 

export IFS=";"

for d in $doms; do
    domains+=($d)
    ./init-letsencrypt_params_TEST.sh -d $d -p $data_path -e $email
done