FROM alpine:3.15.0

RUN apk add --update --no-cache openssh bash

RUN mkdir /etc/ssh/ssh-host-keys /etc/ssh/ssh-authorized-keys

RUN adduser -s /bin/sh -D ssh
RUN echo -n 'ssh:some_password_here' | chpasswd

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY sshd_config /etc/ssh/

ENTRYPOINT [ "/entrypoint.sh" ]