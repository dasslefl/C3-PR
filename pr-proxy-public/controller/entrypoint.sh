#!/bin/bash

# Entrypoint des ssh-Servers

echo "Starte Control-Server..."

/usr/bin/websocketd -devconsole -dir /ws-bin -maxforks 64 -port 81 &

redis-server /redis.conf