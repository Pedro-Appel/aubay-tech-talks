FROM grafana/grafana:11.2.0-ubuntu

USER root

COPY . /scripts/

WORKDIR /scripts

RUN apt-get update && apt-get install curl -y

RUN chmod +x /scripts/grafana_setup.sh

ENTRYPOINT /scripts/grafana_setup.sh
