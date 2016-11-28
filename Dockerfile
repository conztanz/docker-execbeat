FROM debian:jessie

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch x-pack beat execbeat"

COPY ./src/ /run/
RUN chmod +x -R /run

# config
COPY config/execbeat.yml /.backup/execbeat/execbeat.yml
RUN  rm -f /etc/execbeat/execbeat.yml

# bin
RUN sh /run/setup/execbeat.sh \
&&  export PATH=$PATH:/usr/bin

ENV EXECBEAT_USER="" \
    EXECBEAT_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200"

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["execbeat", "-c /etc/execbeat/execbeat.yml", "-path.config /etc/execbeat", "-e","-v"]