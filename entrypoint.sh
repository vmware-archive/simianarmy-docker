#!/bin/bash
set -e

for file in /etc/simianarmy/*.properties; do
    SRC=$file
    DEST=`basename $file`
    echo Setting $DEST from $SRC
    envsubst < $SRC > /usr/local/tomcat/webapps/simianarmy/WEB-INF/classes/$DEST
done

exec "$@"
