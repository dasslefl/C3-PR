# Steuer-Server
# Verbindet den Roboter mit den Frontend via Redis und Websockets

FROM alpine:3.14

RUN apk add --no-cache redis bash

COPY websocketd /usr/bin
RUN chmod +x /usr/bin/websocketd

COPY redis.conf /

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY cgi-bin /cgi-bin
RUN chmod +x /cgi-bin/* || true

COPY ws-bin /ws-bin
RUN chmod +x /ws-bin/* || true

ENTRYPOINT ["/entrypoint.sh"]