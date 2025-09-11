#!/usr/bin/env bash

# Set default MooseFS enviroment to PRODUCTION
MFS_ENV="${MFS_ENV:-PROD}"

#Set correct owner
chown -R mfs:mfs /var/lib/mfs

# Overwrite mfsmaster.cfg if passed in
# this will base64 decode MFS_MASTER_CONFIG variable text
# substitute any env variables in decoded text
# save text into /etc/mfs/mfsmaster.cfg
if [ ! -z ${MFS_MASTER_CONFIG+X} ];
    then
        echo $MFS_MASTER_CONFIG | base64 -d | envsubst > /etc/mfs/mfsmaster.cfg
fi

# We have to be sure that we have metadata files
if [ -f /var/lib/mfs/metadata.mfs ];
then
    exec mfsmaster -f
else
    if [[ -f /var/lib/mfs/metadata.mfs.back.1 && -f /var/lib/mfs/changelog.0.mfs ]];
    then
        echo "Can't find metadata.mfs file"
        echo "Let's try to restore it"
        exec mfsmaster -a -f
    else
        if [  "$MFS_ENV" == "TEST" ];
        then
            echo "MFSM NEW" > /var/lib/mfs/metadata.mfs
            exec mfsmaster -f
        else
            echo "No /var/lib/mfs/metadata.mfs file!"
            echo "EXITING - THIS IS A PRODUCTION ENVIRONMENT!"
            exit 1
        fi
    fi
fi
