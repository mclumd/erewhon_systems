#!/bin/csh -f

# watchdog.sh: requires a single argument, the BASENAME that will be
# used to store data, e.g. /tmp/PRODIGY.  All filenames handled by the
# Watchdog must begin with the BASENAME.

# NOTE: A Watchdog Reset should be done on the same machine the
# Watchdog was started from, because a Reset tries to kill the
# (possibly still alive) Watchdog process.

####################### Site-specific Variables ########################

# Path in which watchdog.sh and associated scripts reside.
set WATCHDOG_PATH = $fmat/Watch.dog/

# Bitmaps for xbiff command to display for user notification.
set PRODIGY_BITMAP = $fmat/Watch.dog/prodigy.bm
set FORMAT_BITMAP = $fmat/Watch.dog/format-tree.bm

# How many seconds one process is allowed to shut down after a STOP from
# the other process.  After this time, the Watchdog will exit
# automatically.
set SHUTDOWN_TIME = 60

# Check for new messages every XBIFF_UPDATE seconds.
set XBIFF_UPDATE = 5

############################# End Variables ############################

# Start Basic Script
set BASENAME = $argv[1]

set SHOW_FILES = 1
# Get flag to display files to screen
if ($#argv == 2) then
   if ($argv[2] == "NO") then
      set SHOW_FILES = 0
   endif
endif

# See if another Watchdog is running.
if (-e $BASENAME.watchdog-status) then
   set ERR = /tmp/watchdog-error.$$
   echo Watchdog error for $BASENAME\: > $ERR
   echo Either another Watchdog is running, or the previous Watchdog >> $ERR
   echo did not exit properly. >> $ERR
   echo "" >> $ERR
   echo If you do not believe another Watchdog is running, >> $ERR
   echo reset the Watchdog and start again. >>$ERR
   if ($SHOW_FILES == 1) then
      set LINES = `cat $ERR | wc -l`
      set LINES = `expr $LINES + 20`
      xterm -title "Watchdog Error" -name "Watchdog Error" \
            -geometry 80x50+100+100 -sb -sl $LINES \
            -e $WATCHDOG_PATH/show-file.sh $ERR DELETE &
   else
      echo =================================================================
      cat $ERR
      rm -f $ERR
      echo =================================================================
   endif
   exit 1
endif

onintr ABORT

# Reset the Watchdog - i.e., clean up old data files, etc.
set WRES = `$WATCHDOG_PATH/reset-watchdog.sh $BASENAME`
if ($WRES == "Failed") then
   exit 1
endif

# Start up Watchdog
set WS_COUNT = 1
set SERVER = $BASENAME.server.1
set WC_COUNT = 1
set CLIENT = $BASENAME.client.1

set DWS_COUNT = 1
set DWC_COUNT = 1
set DISPCLIENT = $BASENAME.client.1
set DISPSERVER = $BASENAME.server.1
set LDCLIENT = "None"
set LDSERVER = "None"


set LASTCLIENT = "None"
set LASTSERVER = "None"

# Use xbiff to signal when new data has arrived.
if ($SHOW_FILES == 1) then
   xbiff -file $BASENAME.watchdog-xbiff -update 5 -geometry 65x65\
         -xrm "xbiff*fullPixmap:$PRODIGY_BITMAP" \
         -xrm "xbiff*emptyPixmap:$FORMAT_BITMAP" & 
endif

echo > $BASENAME.watchdog-xbiff

# Remember process number for Watchdog in case it dies unexpectedly.
echo $$ > $BASENAME.watchdog-pid

echo Watchdog looking for $CLIENT > $BASENAME.watchdog-status
echo Watchdog looking for $SERVER >> $BASENAME.watchdog-status

set STOP
set TIMEOUT

while (1)
  # Check for STOP messages
  if (((-e $BASENAME.client.STOP) && (-e $BASENAME.server.STOP)) || $STOP) then
     # Kill jobs running in background.
     jobs -l > /tmp/watchdog-jobs.$$
#     $WATCHDOG_PATH/kill-csh-jobs.sh /tmp/watchdog-jobs.$$
     rm /tmp/watchdog-jobs.$$
     # Notify error if STOP timeout occurred.
     if ($STOP) then
        set ERR = /tmp/watchdog-error.$$
        if (-e $BASENAME.client.STOP) then
           set PROCESS = Server
        else
           set PROCESS = Client
        endif
        echo Watchdog Error: > $ERR
        echo $PROCESS did not stop within $SHUTDOWN_TIME seconds. >> $ERR
        echo Watchdog Shutting down anyway. >> $ERR
        if ($SHOW_FILES == 1) then
           set LINES = `cat $ERR | wc -l`
           set LINES = `expr $LINES + 20`
           xterm -title "Watchdog Error" -name "Watchdog Error" \
              -geometry 80x50+100+100 -sb -sl $LINES \
              -e $WATCHDOG_PATH/show-file.sh $ERR DELETE &
        else
           echo ==============================================================
           cat $ERR
           rm -f $ERR
           echo ==============================================================
        endif
     endif
     rm -f $BASENAME.client.STOP >& /dev/null
     rm -f $BASENAME.server.STOP >& /dev/null
     rm -f $BASENAME.server* >& /dev/null
     rm -f $BASENAME.client* >& /dev/null
     rm -f $BASENAME.watchdog* >& /dev/null
     exit 0
  endif
  if (-e $BASENAME.client.STOP) then
     if (! $TIMEOUT) then
        echo Received STOP message from Client at `date`\
             >> $BASENAME.watchdog-status
        # Start timeout 
        set TIMEOUT = 1
     endif
  endif
  if (-e $BASENAME.server.STOP) then
     if (! $TIMEOUT) then
        echo Received STOP message from Server at `date`\
             >> $BASENAME.watchdog-status
        # Start timeout 
        set TIMEOUT = 1
     endif
  endif
  # Display any new Client messages that have arrived.
  if ((-e $DISPCLIENT) && ($DISPCLIENT != $LDCLIENT)) then
     echo Found Client $DISPCLIENT
     # Show Client message
     echo Watchdog found Client data $DWC_COUNT at `date` \
          >> $BASENAME.watchdog-status
     if ($SHOW_FILES == 1) then
        set LINES = `cat $DISPCLIENT | wc -l`
        set LINES = `expr $LINES + 20`
#        xterm -geometry 80x50+100+100 -title "Prodigy $DWC_COUNT" \
#           -name "Prodigy $DWC_COUNT" -iconic -sb -sl $LINES \
#           -e $WATCHDOG_PATH/show-file.sh $DISPCLIENT &
     else
        echo ==================== $DISPCLIENT ========================
        cat $DISPCLIENT
        echo =================================================================
     endif
     set LDCLIENT = $DISPCLIENT
     set DWC_COUNT = ` expr $DWC_COUNT + 1`
     set DISPCLIENT = $BASENAME.client.$DWC_COUNT
  endif

  # Display any new Server messages that have arrived.
  if ((-e $DISPSERVER) && ($DISPSERVER != $LDSERVER)) then
     # Show Server message
     echo Found Server $DISPSERVER
     echo Watchdog found Server data $DWS_COUNT at `date` \
          >> $BASENAME.watchdog-status
     if ($SHOW_FILES == 1) then
        set LINES = `cat $DISPSERVER | wc -l`
        set LINES = `expr $LINES + 20`
        xterm -geometry 80x50+100+100 -title "Advice $DWS_COUNT" \
           -name "Advice $DWS_COUNT" -iconic -sl $LINES -sb \
           -e $WATCHDOG_PATH/show-file.sh $DISPSERVER &
     else
        echo ==================== $DISPSERVER ========================
        cat $DISPSERVER
        echo =================================================================
     endif

     # Notify user that server data is available.
     echo $DISPSERVER >> $BASENAME.watchdog-xbiff

     # Prepare for next server data file
     set LDSERVER = $DISPSERVER
     set DWS_COUNT = ` expr $DWS_COUNT + 1`
     set DISPSERVER = $BASENAME.server.$DWS_COUNT
  endif

  # Send Server data to client if available.
  if (-e $SERVER) then
     if (! (-e $BASENAME.server)) then
        # Server data can be sent to client
        echo Watchdog sent Server data $WS_COUNT to Client at `date` \
             >> $BASENAME.watchdog-status

        # Provide Server message to client
        ln -s $SERVER $BASENAME.server
   
        # Remove reference to the last server message processed by the client
        if ($LASTSERVER != "None") then
           rm -f $LASTSERVER
        endif
        set LASTSERVER = $SERVER

        # Prepare filename for next Server message
        set WS_COUNT = `expr $WS_COUNT + 1`
        set SERVER = $BASENAME.server.$WS_COUNT
        echo Looking for Server $SERVER
     else
       # Server message already exists, but Client has not completed processing
     endif
  endif
  # Send Client data to server if available.
  if (-e $CLIENT) then
     if (! (-e $BASENAME.client)) then
       # Client data can be sent to server
       echo Watchdog sent client data $WC_COUNT to server at `date` \
            >> $BASENAME.watchdog-status

       # Provide Client message to server
       ln -s $CLIENT $BASENAME.client

       # Remove reference to the last client message processed by the server
       if ($LASTCLIENT != "None") then
          rm -f $LASTCLIENT
       endif
       set LASTCLIENT = $CLIENT

       # Prepare filename for next Client message
       set WC_COUNT = `expr $WC_COUNT + 1`
       set CLIENT = $BASENAME.client.$WC_COUNT
       echo Looking for Client $CLIENT
     else
       # Client message already exists, but Server has not completed processing
     endif
  endif
  if ($TIMEOUT) then
     # Give the other process SHUTDOWN_TIME seconds to shut down.
     set TIMEOUT = `expr $TIMEOUT + 1`
     if (`expr $TIMEOUT \> $SHUTDOWN_TIME` == 1) then
        set STOP = 1
     endif
  endif
  sleep 1
end


ABORT:

jobs -l > /tmp/watchdog-jobs.$$
#$WATCHDOG_PATH/kill-csh-jobs.sh /tmp/watchdog-jobs.$$
#rm /tmp/watchdog-jobs.$$

# Reset watchdog in background since it's going to try and kill this very
# script!
echo -n Watchdog Reset
$WATCHDOG_PATH/reset-watchdog.sh $BASENAME &

exit 1
