#!/bin/csh -f

set WATCHDOG_PATH = $fmat/Watch.dog/

if (! ($#argv == 1) ) then
   echo Usage: reset-watchdog.sh BASENAME
   exit 1
endif

set BASENAME = $argv[1]

# Kill current Watchdog process, if it is still running.
if (-e $BASENAME.watchdog-pid) then
   # This is a theoretically dangerous job to do, since the Watchdog could
   # have been killed without removing this PID file, in which case
   # the PID in this file could be re-used and active by a completely
   # different process (since PIDs get reset every what, 30K or so?).
   # In practice, however, this should be a pretty rare occurrence. 
   set PID = `cat $BASENAME.watchdog-pid`
   # Put in the background, since if the process isn't around any more,
   # a kill in the foreground would produce an error that would exit
   # the script before doing anything else.
   kill $PID &
   rm -f $BASENAME.watchdog-pid >& /dev/null
endif

# If some data files were not properly removed during the last
# session, try to remove them now.

rm -f $BASENAME.client* >& /dev/null
rm -f $BASENAME.server* >& /dev/null
rm -f $BASENAME.watchdog* >& /dev/null

set FILE_COUNT = \
    `ls $BASENAME.client* $BASENAME.server* $BASENAME.watchdog* |& grep -v 'No match' | wc -l `

if ($FILE_COUNT != 0) then
   set ERR = /tmp/watchdog-error.$$
   echo Watchdog error: Could not reset Watchdog for >$ERR
   echo $BASENAME. >> $ERR
   echo "" >>$ERR
   echo For the Watchdog to restart, you must delete the files >>$ERR
   echo listed below and start the Watchdog again. >>$ERR
   echo "" >>$ERR
   echo The following files which must be deleted or renamed: >>$ERR
   echo "======================================================" >>$ERR
   ls -l $BASENAME.client* $BASENAME.server* $BASENAME.watchdog* >>$ERR >& /dev/null
   set LINES = `cat $ERR | wc -l`
   set LINES = `expr $LINES + 20`
   xterm -title "Watchdog Error" -name "Watchdog Error" \
         -geometry 80x50+100+100 -sb -sl $LINES \
         -e $WATCHDOG_PATH/show-file.sh $ERR DELETE &
   echo Failed
   exit 1
endif

echo Succeeded
exit 0
