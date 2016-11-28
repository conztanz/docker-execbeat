#!/bin/bash

# CREDENTIALS
if [ "$EXECBEAT_USER" != "" ]; then
    sed -ri "s/elasticsearch.username:[^\r\n]*/elasticsearch.username: $EXECBEAT_USER/" /etc/execbeat/execbeat.yml
    sed -ri "s/elasticsearch.password:[^\r\n]*/elasticsearch.password: $EXECBEAT_PWD/" /etc/execbeat/execbeat.yml
fi
# ELASTICSEARCH URL
sed -ri "s/elasticsearch.hosts:[^\r\n]*/elasticsearch.hosts: [\"http:\/\/$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT\"]/" /etc/execbeat/execbeat.yml
