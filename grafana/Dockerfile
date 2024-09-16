FROM grafana/grafana:11.2.0

USER root

COPY ./grafana_setup.sh /scripts/
COPY ./dash.json /scripts/

WORKDIR /scripts

RUN chmod +x /scripts/grafana_setup.sh

ENTRYPOINT /scripts/grafana_setup.sh
