#!/bin/bash
cp /etc/mfs/mfschunkserver.cfg.sample /etc/mfs/mfschunkserver.cfg

mkdir -p /mnt/hdd0
chmod -R 777 /mnt/hdd0
chown -R mfs:mfs /mnt/hdd0

#Default size if not set
SIZE="${SIZE:- 10}"

echo "/mnt/hdd0 "$SIZE"GiB" >> /etc/mfs/mfshdd.cfg
echo "LABELS=$LABELS" >> /etc/mfs/mfschunkserver.cfg

mfschunkserver start

# wait for mfsmaster startup
ping -c 10 mfsmaster

mkdir -p /mnt/moosefs

# mount mfs
mfsmount /mnt/moosefs -H mfsmaster

# create example file to MooseFS
echo "If you can find this file in /mnt/moosefs/welcome_to_moosefs.txt on your client instance it means MooseFS is working correctly, congratulations!" > /mnt/moosefs/welcome_to_moosefs.txt

# list files in MooseFS
ls /mnt/moosefs/
tree /mnt/moosefs/

if [[ $1 == "-d" ]]; then
    while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
