#!/usr/bin/env bash

## https://www.percona.com/blog/2012/01/18/backing-up-binary-log-files-with-mysqlbinlog/

source $1
cd $BACKUPDIR

echo "Backup dir: $BACKUPDIR "

while :
do
LASTFILE=`ls -1 $BACKUPDIR|grep -v orig|tail -n 1`
TIMESTAMP=`date +%s`
FILESIZE=$(stat -c%s "$LASTFILE")

if [ $FILESIZE -gt 0 ]; then
    echo "Backing up last binlog"
    mv $LASTFILE $LASTFILE.orig$TIMESTAMP
fi
touch $LASTFILE
echo "Starting live binlog backup"
$MBL --raw --read-from-remote-server --stop-never --host $MYSQLHOST --port $MYSQLPORT -u $MYSQLUSER -p$MYSQLPASS $LASTFILE

echo "mysqlbinlog exited with $? trying to reconnect in $RESPAWN seconds."

sleep $RESPAWN
done