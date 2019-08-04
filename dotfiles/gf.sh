#!/bin/bash

if ! -f "gf.ip"; then
    touch "gf.ip"
    echo "Fill gf.ip with the server IP address and re-run"
    exit 1
fi

IP=`cat gf.ip`

/opt/TurboVNC/bin/vncviewer -via root@$IP -quality 75 127.0.0.1:5901

