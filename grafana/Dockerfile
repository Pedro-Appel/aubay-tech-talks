FROM ubuntu:20.04

USER root

COPY ./grafana_setup.sh /scripts/
COPY ./dash.json /scripts/

WORKDIR /scripts

RUN apt-get update && apt-get install curl -y

RUN chmod +x /scripts/grafana_setup.sh

ENTRYPOINT /scripts/grafana_setup.sh
