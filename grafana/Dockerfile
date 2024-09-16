FROM grafana/grafana:11.2.0-ubuntu

USER root

COPY ./grafana_setup.sh /scripts/
COPY ./dash.json /scripts/

WORKDIR /scripts

RUN apt-get update && apt-get install curl -y
RUN apt-get update && apt-get install dos2unix
RUN dos2unix /scripts/grafana_setup.sh

RUN chmod +x /scripts/grafana_setup.sh

ENTRYPOINT /scripts/grafana_setup.sh
