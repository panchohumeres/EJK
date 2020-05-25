## Index_patterns:
* [TEST] incoming_logs*: "_id" : "index-pattern:3f0647a0-e53e-11e9-a07d-2dba5adf8ca0"
incoming_logs="1fce7f30-ea0a-11e9-a07d-2dba5adf8ca0"*

## Obtener info de un Index Pattern

* GET *.kibana/_search?q=type:index-pattern%20AND%20index-pattern.title:logs_incoming_test*
*GET _all/_settings*

* GET */_cluster/state/_all/* 

## Obtener listado de índices y espacio que ocupan

* GET */_cat/indices*

## Borrar índice

DELETE _readings

## Obtener información de privilegios para el cluster (por ejemplo si índices están bloqueados por watermark)
* GET *_security/user/_privileges*

## 

curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'

PUT _all/_settings
{"index.blocks.read_only_allow_delete": null}

PUT _all/_settings
{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }