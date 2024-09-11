FROM debian

USER root

COPY ./client.sh /scripts/client.sh

RUN apt-get update && apt-get install dos2unix
RUN dos2unix /scripts/client.sh


RUN sleep 10


RUN apt update && \
        apt install curl -y && \
        chmod +x /scripts/client.sh

ENTRYPOINT ["/scripts/client.sh"]
