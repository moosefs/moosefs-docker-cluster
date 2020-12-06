#!/usr/bin/env bash

CMD="mfscgiserv -f"

#Add host if set
if [ ! -z ${MASTER_HOST+X} ];
    then
        CMD="$CMD -H $MASTER_HOST"
fi

#Add host if set
if [ ! -z ${MASTER_PORT+X} ];
    then
        CMD="$CMD -P $MASTER_PORT"
fi

exec $CMD
