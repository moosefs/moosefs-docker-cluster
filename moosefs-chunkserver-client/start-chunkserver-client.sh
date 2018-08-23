#!/bin/bash
cp /etc/mfs/mfschunkserver.cfg.sample /etc/mfs/mfschunkserver.cfg

mkdir -p /mnt/sdb1
chmod -R 777 /mnt/sdb1
echo "/mnt/sdb1 10GiB" >> /etc/mfs/mfshdd.cfg

ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'

sed -i '/# LABELS =/c\LABELS = DOCKER' /etc/mfs/mfschunkserver.cfg
sed -i '/MFSCHUNKSERVER_ENABLE=false/c\MFSCHUNKSERVER_ENABLE=true' /etc/default/moosefs-chunkserver
mfschunkserver start

# wait for mfsmaster startup
ping -c 10 mfsmaster

mkdir -p /mnt/mfs

# mount mfs
mfsmount /mnt/mfs -H mfsmaster

# create example file to MooseFS
echo "If you can find this file in /mnt/mfs/SUCCESS on your client instance it means MooseFS is working correctly, congratulations!" > /mnt/mfs/welcome_to_moosefs.txt

# list files in MooseFS
ls /mnt/mfs/

if [[ $1 == "-d" ]]; then
    while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
