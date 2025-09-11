#!/usr/bin/env bash

# Set default MooseFS enviroment to PRODUCTION
MFS_ENV="${MFS_ENV:-PROD}"

# Set a correct owner
chown -R mfs:mfs /var/lib/mfs

# Overwrite mfsmetalogger.cfg if passed in
# this will base64 decode MFS_METALOGGER_CONFIG variable text
# substitute any env variables in decoded text
# save text into /etc/mfs/mfsmetalogger.cfg
if [ ! -z ${MFS_METALOGGER_CONFIG+X} ];
    then
        echo $MFS_METALOGGER_CONFIG | base64 -d | envsubst > /etc/mfs/mfsmetalogger.cfg
fi

# Run
exec mfsmetalogger -f
