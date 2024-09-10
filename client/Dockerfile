FROM debian

USER root

COPY ./client.sh /scripts/client.sh

RUN sleep 10

RUN apt update && \
        apt install curl -y && \
        chmod +x /scripts/client.sh

ENTRYPOINT ["/scripts/client.sh"]
