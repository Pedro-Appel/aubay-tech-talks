#!/bin/bash

# Create prometheus datasource
curl -X POST http://admin:admin@host.docker.internal:3000/api/datasources \
    -u "admin:admin" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d '{ "name": "prometheus", "uid":"prom-data", "type": "prometheus", "access": "proxy", "url": "http://host.docker.internal:9090", "basicAuth": true, "isDefault":true}' \

# Import dashboard
json=$(<dash.json)
payload="{\"dashboard\": $json, \"overwrite\": true}"

curl -X POST http://admin:admin@host.docker.internal:3000/api/dashboards/import \
    -u "admin:admin" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "$payload"
