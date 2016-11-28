#!/bin/bash
mkdir -p /etc/execbeat

if [ ! -f /etc/execbeat/execbeat.yml ]; then
    cp /.backup/execbeat/execbeat.yml /etc/execbeat/execbeat.yml
fi

if [ ! -f /etc/execbeat/execbeat.template.json ]; then
    cp /.backup/execbeat/execbeat.template.json /etc/execbeat/execbeat.template.json
fi

if [ ! -f /etc/execbeat/execbeat.template-es2x.json ]; then
    cp /.backup/execbeat/execbeat.template-es2x.json /etc/execbeat/execbeat.template-es2x.json
fi