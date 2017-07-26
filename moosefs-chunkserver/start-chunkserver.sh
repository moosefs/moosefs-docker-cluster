#!/bin/bash
cp /etc/mfs/mfschunkserver.cfg.sample /etc/mfs/mfschunkserver.cfg

mkdir -p /mnt/sdb1
chown -R mfs:mfs /mnt/sdb1
echo "/mnt/sdb1 10GiB" >> /etc/mfs/mfshdd.cfg

ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'

sed -i '/# LABELS =/c\LABELS = DOCKER' /etc/mfs/mfschunkserver.cfg
sed -i '/MFSCHUNKSERVER_ENABLE=false/c\MFSCHUNKSERVER_ENABLE=true' /etc/default/moosefs-chunkserver
mfschunkserver start

if [[ $1 == "-d" ]]; then
    while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
