#!/usr/bin/env bash

mkdir -p /mnt/hdd0/mfs
# Set correct owner
chown -R mfs:mfs /mnt/hdd0 /mnt/hdd0/mfs /var/lib/mfs

# Overwrite mfschunkserver.cfg if passed in
# this will base64 decode MFS_CHUNKSERVER_CONFIG variable text
# substitute any env variables in decoded text
# save text into /etc/mfs/mfschunkserver.cfg
if [ ! -z ${MFS_CHUNKSERVER_CONFIG+X} ];
    then
        echo $MFS_CHUNKSERVER_CONFIG | base64 -d | envsubst > /etc/mfs/mfschunkserver.cfg
fi

# Overwrite mfshdd.cfg if passed in
# this will base64 decode MFS_HDD_CONFIG variable text
# substitute any env variables in decoded text
# save text into /etc/mfs/mfshdd.cfg
if [ ! -z ${MFS_HDD_CONFIG+X} ];
    then
        echo $MFS_HDD_CONFIG | base64 -d | envsubst > /etc/mfs/mfshdd.cfg
fi


#Add size to hdd if defined
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

if [ ! -z ${MASTER_HOST+X} ];
    then
        echo "MASTER_HOST=$MASTER_HOST" >> /etc/mfs/mfschunkserver.cfg
fi
if [ ! -z ${CSSERV_LISTEN_PORT+X} ];
    then
        echo "CSSERV_LISTEN_PORT=$CSSERV_LISTEN_PORT" >> /etc/mfs/mfschunkserver.cfg
fi
if [ ! -z ${DATA_PATH+X} ];
    then
        echo "DATA_PATH=$DATA_PATH" >> /etc/mfs/mfschunkserver.cfg
fi

exec mfschunkserver -f
