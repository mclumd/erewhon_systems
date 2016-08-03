#!/bin/csh -f

# Fake ForMAT that spits out history files every SLEEP seconds.
# It doesn't read server responses.

# Usage: fake-format.sh BASENAME history-files

#SLEEP was 10. 
set SLEEP = 15
set BASENAME = $argv[1]
set COUNT = 1

shift

if (! -e $BASENAME.watchdog-status) then
   echo Server Error: Watchdog not running.  Exiting.
   exit 1
endif

foreach hist ($argv)
  echo Sending history file $hist. to $BASENAME.client.$COUNT
  cp $hist $BASENAME.client.$COUNT
  set COUNT = `expr $COUNT + 1`
  sleep $SLEEP
end

touch $BASENAME.client.STOP
