#!/bin/bash

# Der gute Wille auf den Server war da, auf den Pi sollten aber Scripts reichen.

if [ -z "$SERVER_HOST" ]; then
      echo "\$SERVER_HOST ist nicht gesetzt. Diese Variable muss auf die öffentlche IP des Reverse Proxys gesetzt werden."
      exit;
fi

if [ -z "$ROBOT_HOST" ]; then
      echo "\$ROBOT_HOST ist nicht gesetzt. Diese Variable muss auf die WLAN-IP des PR gesetzt werden."
      exit;
fi

[ -f /tmp/pids ] && kill $(cat /tmp/pids) 2>/dev/null >/dev/null
[ -f /tmp/pids ] && rm /tmp/pids

# SSH Tunnel für HTTP
bash -c "while true; do ssh ssh@$SERVER_HOST -tt -p 2200 -L 9001:nginx:81; sleep 2s; done" &
echo -n "$! " >> /tmp/pids

# SSH Tunnel für Stream
bash -c "while true; do ssh ssh@$SERVER_HOST -tt -p 2200 -L 9002:streamer:8000; sleep 2s; done" &
echo -n "$! " >> /tmp/pids

# Restream vom Roboter
# -Y 1000 -y 3 sorgt dafür dass wenn Verbindung im laufenden Betrieb abbricht curl neu gestartet wird
bash -c "while true; do curl --connect-timeout 3 -Y 1000 -y 3 $ROBOT_HOST:81/stream > /dev/tcp/localhost/9002; sleep 2s; done;" &
echo -n "$! " >> /tmp/pids