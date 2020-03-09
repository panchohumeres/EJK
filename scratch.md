   
   
    docker run --rm -ti taskrabbit/elasticsearch-dump \
      --input=http://production.es.com:9200/my_index \
      --output=http://staging.es.com:9200/my_index \
      --type=data




docker run -v /home/francisco/Desktop/repos/data/mockup:/tmp --network=host -ti --entrypoint=/bin/sh taskrabbit/elasticsearch-dump -i ------>mismo caso anterior, montando volumen (se recomienda se llame "tmp" el del contenedor)


curl --cacert certs/ca/ca.crt https://elastic:@104.43.168.254:9200/_cat/indices

curl https://elastic:@localhost:9200/_cat/indices

# probar índice en host (funciona)
curl --cacert ./certs/ca/ca.crt https://elastic:@localhost:9200/kibana_sample_data_flights

# MIGRAR índice desde dentro del contenedor rabbit (funciona)
elasticdump \
      --input=https://elastic:@localhost:9200/kibana_sample_data_flights \
      --input-ca=/tmp/certs/ca/ca.crt \
      --output=https://elastic:@localhost:9000/kibana_sample_data_flights \
      --output-ca=/tmp/dummy/certs/ca/ca.crt \
      --tlsAuth \
      --type=data


curl --cacert /tmp/certs/ca/ca.crt https://elastic:@localhost:9200/kibana_sample_data_flights

    docker run --net=host --rm -ti taskrabbit/elasticsearch-dump -v /home/francisco/Desktop/repos/data/mockup:/tmp \
      --input=https://elastic:@localhost:9200/kibana_sample_data_flights \
      --input-ca=/tmp/certs/ca/ca.crt \
      --output=https://elastic:@localhost:9000/kibana_sample_data_flights \
      --output-ca=/tmp/dummy/certs/ca/ca.crt \
      --tlsAuth \
      --type=data


docker run --rm -ti -v /home/francisco/Desktop/repos/data/mockup:/tmp taskrabbit/elasticsearch-dump \
  --input=http://production.es.com:9200/my_index \
  --output=/tmp/my_index_mapping.json \
  --type=data


NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
      --input=https://elastic:@localhost:9200/kibana_sample_data_flights \
      --input-ca=/tmp/certs/ca/ca.crt \
      --output=https://elastic:@localhost:9000/kibana_sample_data_flights \
      --output-ca=/tmp/dummy/certs/ca/ca.crt \
      --tlsAuth \
      --type=data



elasticdump \
      --input=http://elastic:@localhost:9200/kibana_sample_data_flights \
      --input-ca=/tmp/certs/ca/ca.crt \
      --output=http://elastic:@localhost:9000/kibana_sample_data_flights \
      --output-ca=/tmp/dummy/certs/ca/ca.crt \
      --tlsAuth \
      --type=data \
      --input-key=/tmp/certs/es01/es01.key \
      --output-key=/tmp/dummy/certs/es01/es01.key \
      --input-cert=/tmp/certs/es01/es01.crt \
      --output-cert=/tmp/dummy/certs/es01/es01.crt



docker-compose -f create-certs-http.yml run --rm create_certs

docker-compose -f create-certs-http.yml config

curl -u elastic: https://staging.elastic.work.cl:9200 --cacert ca/ca.crt -k

curl -u elastic: https://localhost:9200 --cacert ca/ca.crt

curl -u elastic: https://es01:9200 --cacert ca/ca.crt

nuevo index pattern 3ded1590-4ee0-11ea-bc38-a598c9e2380b 'monitors_pivot'

#stats ch


"title":"stats-ch_root"},"id":"72d56610-56c7-11ea-bc38-a598c9e2380b" --->nuevo index pattern


./init-letsencrypt.sh -domains  -data_path "../data/certbot" -email "francisco@gmail.com"

