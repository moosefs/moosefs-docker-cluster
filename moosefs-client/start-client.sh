#!/bin/bash

# wait for mfsmaster startup
sleep 10

# set mfsmaster ip
echo "$2      mfsmaster" >> /etc/hosts

mkdir -p /mnt/mfs

# mount mfs
mfsmount /mnt/mfs -H mfsmaster

# create example file to MooseFS
echo "If you can find this file in /mnt/mfs/SUCCESS on your client instance it means MooseFS is working correctly, congratulations!" > /mnt/mfs/SUCCESS

# list files in MooseFS
ls /mnt/mfs/SUCCESS -la

if [[ $1 == "-d" ]]; then
    while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
