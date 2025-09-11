#!/usr/bin/env bash

CMD="mfsgui -f"

mkdir -p /etc/mfs
echo "GUISERV_LISTEN_PORT = 9425" > /etc/mfs/mfsgui.cfg

#Add GUI port if set
if [ ! -z ${GUI_PORT+X} ];
    then
        echo "GUISERV_LISTEN_PORT = $GUI_PORT" > /etc/mfs/mfsgui.cfg
fi

exec $CMD
