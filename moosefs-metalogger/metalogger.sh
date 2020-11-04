#!/usr/bin/env bash

# Set default MooseFS enviroment to PRODUCTION
MFS_ENV="${MFS_ENV:-PROD}"

# Set a correct owner
chown -R mfs:mfs /var/lib/mfs

# Run
exec mfsmetalogger -f
