#!/bin/bash

# Entrypoint des Stream-Empängers
echo "Starte Stream-Empfänger..."

# Fanout Kernel Modul aufsetsen
rmmod fanout
modprobe fanout buffersize=1000000 || (echo "Fanout Kernel-Modul konnte nicht geladen werden."; exit)

FANOUTMAJOR=`grep fanout /proc/devices | awk '{print $1}'`
mknod /dev/fanout-stream c $FANOUTMAJOR 0
chmod 666 /dev/fanout-stream

# Empfangene Daten über Fanout wieder raus kotzen (PubSub-Verteiler für Arme)
nc -kdl 8000 > /dev/fanout-stream &

# httpd-Server für Stream mittels CGI-Skript
busybox-extras httpd -p 80 -f -h /html
