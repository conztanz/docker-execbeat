[![](https://images.microbadger.com/badges/image/khezen/execbeat.svg)](https://hub.docker.com/r/khezen/execbeat/)

# Supported tags and respective `Dockerfile` links

* `2.0.0`, `2.0`, `2`, `latest` [(2.0/Dockerfile)](https://github.com/Khezen/docker-execbeat/blob/2.0/Dockerfile)

# What is Execbeat?
Execbeat is a [Beat](https://www.elastic.co/products/beats) used to execute any command. 
Multiple commands can be configured which are executed in a regular interval and the standard output and standard error is shipped to the configured output channel.

[<img src="https://static-www.elastic.co/fr/assets/blt121ead33d4ed1f55/icon-beats-bb.svg?q=455" width="144" height="144">](https://www.elastic.co/fr/products/beats)

# How To Use

## docker engine

```
docker run -d khezen/execbeat:latest   
```

## docker-compose

### [File Descriptors and MMap](https://www.elastic.co/guide/en/elasticsearch/guide/current/_file_descriptors_and_mmap.html)

run the following command on your host:
```
sysctl -w vm.max_map_count=262144
```
You can set it permanently by modifying `vm.max_map_count` setting in your `/etc/sysctl.conf`.

### docker-compose.yml
```
version: '2'
services:    
    execbeat:
        image: khezen/execbeat
        environment:
            EXECBEAT_USER: execbeat
            EXECBEAT_PWD: changeme
            ELASTICSEARCH_HOST: localhost
            ELASTICSEARCH_PORT: 9200
        volumes:
            - /etc/execbeat:/etc/execbeat
            - /usr/share/scripts:/usr/share/scripts
        network_mode: bridge
        restart: always

```
or

```
version: '2'
services:
    elasticsearch:
        image: khezen/elasticsearch
        environment:
            ELASTIC_PWD: changeme
            KIBANA_PWD: brucewayne
            BEATS_PWD: jdilla
        volumes:
            - /data/elasticsearch:/usr/share/elasticsearch/data
            - /etc/elasticsearch:/usr/share/elasticsearch/config 
        ports:
             - "9200:9200"
             - "9300:9300"
        network_mode: bridge
        restart: always

    kibana:
        links:
            - elasticsearch
        image: khezen/kibana:5
        environment:
            KIBANA_PWD: brucewayne
            ELASTICSEARCH_HOST: elasticsearch
            ELASTICSEARCH_PORT: 9200
        volumes:
            - /etc/kibana:/etc/kibana
        ports:
             - "5601:5601"
        network_mode: bridge
        restart: always
    
    execbeat:
        links:
            - elasticsearch
        image: khezen/execbeat
        environment:
            EXECBEAT_USER: beats
            EXECBEAT_PWD: jdilla
            ELASTICSEARCH_HOST: elasticsearch
            ELASTICSEARCH_PORT: 9200
        volumes:
            - /etc/execbeat:/etc/execbeat
            - /usr/share/scripts:/usr/share/scripts
        network_mode: bridge
        restart: always

```
# Environment Variables

##### EXECBEAT_USER | `(empty by default)`
Elasticsearch user for this beat. If left empty: authentication is not defined in configuration file.

##### EXECBEAT_PWD | `changeme`
password for elasticsearch user **EXECBEAT_USER**.

##### ELASTICSEARCH_HOST | `elasticsearch`
Elasticsearch hostname.

##### ELASTICSEARCH_PORT | `9200`
Elasticsearch port.

# Configure Execbeat

Configuration file is located in `/etc/execbeat/execbeat.yml` if you follow the same volume mapping as in docker-compose examples above.

You can find help with execbeat configuration [here](https://github.com/christiangalsterer/execbeat/blob/master/docs/configuration.asciidoc).

# Share scripts from host

You can share scripts from your host to the container by adding them to `/usr/share/scripts` if you follow the same volume mapping as in docker-compose exammples above.

# User Feedback
## Issues
If you have any problems with or questions about this image, please ask for help through a [GitHub issue](https://github.com/Khezen/docker-execbeat/issues).

# Credit

[christiangalsterer/execbeat](https://github.com/christiangalsterer/execbeat)