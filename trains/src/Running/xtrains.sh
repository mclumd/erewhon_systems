#!/bin/sh
#
# xtrains: Start X for running TRAINS
#
# George Ferguson, ferguson@cs.rochester.edu, 17 Sep 1996
# Time-stamp: <Mon Jan 20 14:51:39 EST 1997 ferguson>
#

echo 'Starting X for TRAINS-96 v2.2'
TRAINS_BASE_DEFAULT=/u/trains/96/2.2

# Get current hostname
current_host=`/bin/uname -n | cut -d. -f1`

# Make sure DISPLAY is set
if test -z "$DISPLAY" -o "$DISPLAY" = ":0.0" -o "$DISPLAY" = ":0" \
        -o "$DISPLAY" = "unix:0" -o "$DISPLAY" = "unix:0.0"; then
    DISPLAY="$current_host:0"
fi

# Set TRAINS_BASE unless set
if test -z "$TRAINS_BASE"; then
    TRAINS_BASE=$TRAINS_BASE_DEFAULT
fi

# Make sure the X binaries are in our PATH
if test -d /opt; then
    # Solaris
    PATH="$PATH:/usr/openwin/bin"; export PATH
else
    # SunOS
    PATH="$PATH:/usr/staff/bin"; export PATH
fi

# Start the X server using our startup file
xinit $TRAINS_BASE/etc/xinit.rc ${1+"$@"}
