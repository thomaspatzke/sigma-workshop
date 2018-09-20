#!/bin/bash

ES=${1:-localhost:9200}

echo -n "Importing Index template..."
if curl --fail -s -X PUT -H "Content-Type: application/json" --data-binary @winlogbeat-6.4.0-custom.template.json "$ES/_template/winlogbeat-6.4.0-custom" > /dev/null
then
    echo "Ok"
else
    echo "Failed!"
    exit 1
fi

echo -n "Importing log data into ES..."
if curl --fail -s -X POST -H "Content-Type: application/json" --data-binary @sigma_workshop_es_logs.bulk.json $ES/_bulk > /dev/null
then
    echo "Ok"
else
    echo "Failed!"
    exit 2
fi

echo -n "Configuring Kibana..."
if curl --fail -s -X POST -H "Content-Type: application/json" --data-binary @kibana-config.bulk.json $ES/_bulk > /dev/null
then
    echo "Ok"
else
    echo "Failed!"
    exit 3
fi
