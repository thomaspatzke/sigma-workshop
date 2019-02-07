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

echo -n "Deleting potentially existing Kibana index pattern..."
if curl --fail -s -X DELETE -H "kbn-version: 6.4.1" -H "Content-Type: application/json" $KIBANA/api/saved_objects/index-pattern/d9085b70-cc00-11e8-979b-49973e02c133 > /dev/null
then
    echo "Ok"
else
    echo "Failed (most likely because it doesn't existed, which is ok)"
fi

echo -n "Importing Kibana index pattern..."
if curl --fail -s -X POST -H "kbn-version: 6.6.0" -H "Content-Type: application/json" --data-binary @kibana-index_pattern.json $KIBANA/api/saved_objects/index-pattern/workshop > /dev/null
then
    echo "Ok"
else
    echo "Failed!"
fi
