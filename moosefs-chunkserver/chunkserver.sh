#!/usr/bin/env bash

# Set correct owner
chown -R mfs:mfs /mnt/hdd0 /var/lib/mfs

#Add size to hdd is defined
if [ -z ${SIZE+X} ];
    then
        echo "/mnt/hdd0" > /etc/mfs/mfshdd.cfg
    else
        echo "/mnt/hdd0 ${SIZE}GiB" > /etc/mfs/mfshdd.cfg
fi

# Add label if defined
if [ ! -z ${LABELS+X} ];
    then
        echo "LABELS=$LABELS" >> /etc/mfs/mfschunkserver.cfg
fi

exec mfschunkserver -f
