#!/bin/bash

IPFILE="gf.ip"

if [ ! -f "$IPFILE" ]; then
    touch $IPFILE
    echo "Fill $IPFILE with the server IP address and re-run"
    exit 1
fi

IP=`cat $IPFILE | xargs`

/opt/TurboVNC/bin/vncviewer -via root@$IP -quality 75 127.0.0.1:5901
