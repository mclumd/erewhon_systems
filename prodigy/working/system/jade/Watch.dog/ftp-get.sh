#!/bin/sh

# Usage: ftp-get.sh FTPDIR FROM_FILE TO_FILE

MACHINE=east.isx.com
FTP_USER=pf
FTP_PASS=pinkfloyd

DIR=$1
FROM=$2
TO=$3

ftp -n << END
open $MACHINE
user $FTP_USER $FTP_PASS
cd $DIR
get $FROM $TO
quit
END

