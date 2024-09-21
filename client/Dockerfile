FROM debian

ARG APP_SERVER
ENV APP_SERVER $APP_SERVER
USER root

COPY ./client.sh /scripts/client.sh

RUN apt update && \
        apt install curl -y && \
        chmod +x /scripts/client.sh

ENTRYPOINT ["/scripts/client.sh"]
