#!/bin/bash

# wait for mfsmaster startup
sleep 5

# set mfsmaster ip
echo "$2      mfsmaster" >> /etc/hosts

mkdir -p /mnt/mfs

# mount mfs
mfsmount /mnt/mfs -H mfsmaster

if [[ $1 == "-d" ]]; then
    while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
