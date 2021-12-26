#!/bin/bash

# Entrypoint des ssh-Servers

echo "Starte SSH-Server..."

# Keys erzeugen
if [ ! -f /etc/ssh/ssh-host-keys/ssh_host_dsa_key ]; then
    echo "Erzeuge SSH-Schlüsselpaare..."
    ssh-keygen -A
    cp -f /etc/ssh/ssh_host_* /etc/ssh/ssh-host-keys/
    rm /etc/ssh/ssh_host_*
fi

# Schauen ob öffentliche Schlüssel hinterlegt sind
if [ ! "$(ls -A /etc/ssh/ssh-authorized-keys/)" ]; then
    echo "Es wurden keine öffentlichen SSH-Schlüssel im Ordner ssh-authorized-keys gefunden. Ohne diese Schlüssel ist der Betrieb nicht möglich."
    sleep 5s
    exit
fi

# Öffentliche Schlüssel autorisieren
rm /etc/ssh/ssh-authorized-keys-file > /dev/null 2>&1
for f in /etc/ssh/ssh-authorized-keys/*; do (cat "${f}"; echo) >> /etc/ssh/ssh-authorized-keys-file; done

exec /usr/sbin/sshd -D -e "$@"