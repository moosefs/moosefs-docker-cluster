#!/bin/bash
cp /etc/mfs/mfsmaster.cfg.sample /etc/mfs/mfsmaster.cfg
cp /etc/mfs/mfsexports.cfg.sample /etc/mfs/mfsexports.cfg

# Add hostname to hosts
ifconfig eth0 | awk '/inet addr/{printf substr($2,6)}' >> /etc/hosts
echo "      mfsmaster" >> /etc/hosts
ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'

mfsmaster start -a
service moosefs-cgiserv start

if [[ $1 == "-d" ]]; then
    while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
