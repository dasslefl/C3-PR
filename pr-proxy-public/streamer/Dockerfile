
# Stream-Empfänger
# Empfängt den MJPEG-Stream via TCP

FROM alpine:3.14

RUN apk add --no-cache netcat-openbsd bash busybox-extras

RUN mkdir -p /html/cgi-bin
COPY cgi-stream /html/cgi-bin
RUN chmod +x /html/cgi-bin/cgi-stream
RUN echo "Hallo Welt" > /html/index.html

COPY splash.jpg /

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]