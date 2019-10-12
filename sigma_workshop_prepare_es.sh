#!/bin/bash

ES=${1:-localhost:9200}
KIBANA=${2:-localhost:5601}

echo -n "Importing Index template..."
if curl --fail -s -X PUT -H "Content-Type: application/json" --data-binary @winlogbeat-6.4.0-custom.template.json "$ES/_template/winlogbeat-6.4.0-custom" > /dev/null
then
    echo "Ok"
else
    echo "Failed!"
fi

echo -n "Importing log data into ES..."
if curl --fail -s -X POST -H "Content-Type: application/json" --data-binary @sigma_workshop_es_logs.bulk.json $ES/_bulk > /dev/null
then
    echo "Ok"
else
    echo "Failed!"
fi

echo -n "Importing Kibana index pattern..."
if curl --fail -s -X POST -H "kbn-xsrf: true" --form file=@kibana_index_pattern.ndjson "$KIBANA/api/saved_objects/_import?overwrite=true" > /dev/null
then
    echo "Ok"
else
    echo "Failed!"
fi
