#!/bin/csh -f

# FTP Watchdog
# Usage: ftp-watch.sh BASENAME FTPDIR [client|server]

# Enable check for running Watchdog

# There is an FTPDIR which the data is put into; the data files have
# the same names as the regular local/remote, minus the BASENAME.

# Implement timeout in case one process does not acknowledge a STOP

# Delete files from FTP dir once processed, delete all on reset.


# **************** Configuration Variables *******************

set WATCHDOG_DIR = $fmat

set SLEEP = 30

# How long to sleep if an FTP error occurs.
set FTP_SLEEP = 30

# **************** Initialize Variables *******************

if ($#argv != 3) then
   echo Usage: $argv[0] BASENAME FTPDIR '[client|server]'
   exit 1
endif

set BASENAME = $argv[1]
set FTPDIR = $argv[2]
set LOCAL = $argv[3]
if ($LOCAL == "client") then
   set REMOTE = "server"
else
   set REMOTE = "client"
endif
set ABORT_STRING = ""

if (! (-e $BASENAME.watchdog-status)) then
   # Watchdog is not running
   set ABORT_STRING = "Error: Watchdog for $BASENAME is not running."
   goto ABORT
endif

set FTP_ERROR = 'access denied|ogin failed|nection refused|ot connected|ost connection'
set FTP_OUT = /tmp/FTP-OUT.$$
set FTP_COUNT = 1
set DOWNLOAD = $BASENAME.$LOCAL.FTP-download

set LOCAL_STOP = 0
set REMOTE_STOP = 0
set DLCOUNT = 1
set ULCOUNT = 1
set LCOUNT = 1
set TOTAL = 0
set WAIT = 0

alias get_file $WATCHDOG_DIR/ftp-get.sh
alias put_file $WATCHDOG_DIR/ftp-put.sh

echo =============================================================
echo Looking for Remote $REMOTE.$DLCOUNT
echo Waiting for Local $BASENAME.$LOCAL.$ULCOUNT
echo =============================================================

while (1)

  set ACTION = 0
  # Download Remote Files
  if ($REMOTE_STOP == 0) then
     # Get Remote Stop
     get_file $FTPDIR $REMOTE.STOP $DOWNLOAD >& $FTP_OUT
     set RESULT = `egrep "$FTP_ERROR" $FTP_OUT | wc -l`
     if ($RESULT == 0) then
        if (-e $DOWNLOAD) then
           # Found Remote Stop
           set ACTION = 1
           echo Downloaded STOP signal from Remote Process
           mv $DOWNLOAD $BASENAME.$REMOTE.STOP
           set REMOTE_STOP = 1
           if ($LOCAL_STOP == 1) then
              set ABORT_STRING = "Received STOP signal"
              goto ABORT
           endif
        endif
     else
        echo Error occurred during download file from Remote Process:
        egrep "$FTP_ERROR" $FTP_OUT
        sleep $FTP_SLEEP
     endif
      
     # Download Remote Data if available
     get_file $FTPDIR $REMOTE.$DLCOUNT $DOWNLOAD >& $FTP_OUT
     set RESULT = `egrep "$FTP_ERROR" $FTP_OUT | wc -l`
     if ($RESULT == 0) then
        if (-e $DOWNLOAD) then
           set ACTION = 1
           mv $DOWNLOAD $BASENAME.$REMOTE.$DLCOUNT
           echo Downloaded file $BASENAME.$REMOTE.$DLCOUNT from Remote Process
           set DLCOUNT = `expr $DLCOUNT + 1`
        endif
     else
        echo Error occurred during download file from Remote Process:
        egrep "$FTP_ERROR" $FTP_OUT
        sleep $FTP_SLEEP
     endif
  endif
  
  # Upload Local Files
  if ($LOCAL_STOP == 0) then
     # Send local Stop
     if (-e $BASENAME.$LOCAL.STOP) then
        put_file $FTPDIR $BASENAME.$LOCAL.STOP $LOCAL.STOP >& $FTP_OUT.STOP
        set RESULT = `egrep "$FTP_ERROR" $FTP_OUT.STOP | wc -l`
        if ($RESULT == 0) then
           set ACTION = 1
           set LOCAL_STOP = 1
           echo Uploaded STOP signal to Remote Process
           if ($REMOTE_STOP == 1) then
              set ABORT_STRING = "Received Remote STOP signal"
              goto ABORT
           endif
        else
           echo Error occurred during upload STOP signal to Remote Process:
           egrep "$FTP_ERROR" $FTP_OUT.STOP
           sleep $FTP_SLEEP
        endif
     endif
     # Send next available local data
     if (-e $BASENAME.$LOCAL.$ULCOUNT) then
        put_file $FTPDIR $BASENAME.$LOCAL.$ULCOUNT $LOCAL.$ULCOUNT >& $FTP_OUT.$ULCOUNT
        set RESULT = `egrep "$FTP_ERROR" $FTP_OUT.$ULCOUNT | wc -l`
        if ($RESULT == 0) then
           set ACTION = 1
           echo Uploaded $BASENAME.$LOCAL.$ULCOUNT to Remote Process
           set ULCOUNT = `expr $ULCOUNT + 1`
        else
           echo Error occurred during upload $BASENAME.$LOCAL.$ULCOUNT to Remote Process
           egrep "$FTP_ERROR" $FTP_OUT.$ULCOUNT
           sleep $FTP_SLEEP
        endif
     endif
  endif

  set WAIT = `expr $WAIT + 1`
  if ($WAIT == 10) then
     set TOTAL = `expr $TOTAL + $WAIT`
     echo =============================================================
     echo Processed $TOTAL cycles.
     set WAIT = 0
     echo Looking for Remote $REMOTE.$DLCOUNT
     echo Waiting for Local $BASENAME.$LOCAL.$ULCOUNT
     echo =============================================================
  endif

  # Only sleep if nothing was done during this pass
  if ($ACTION == 0) then
     sleep $SLEEP
  endif

  if (! (-e $BASENAME.watchdog-status)) then
     # Watchdog has exited
     set ABORT_STRING = "Stop: Watchdog has quit."
     goto ABORT
  endif

end

  
ABORT:
  rm -f $FTP_OUT
  echo $ABORT_STRING
  echo ====================================================================
  echo Be sure to rename FTP_OUT files
  echo ====================================================================
  exit
