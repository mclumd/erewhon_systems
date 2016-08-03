#!/bin/csh -f

# Script to kill jobs listed with the csh "jobs -l" command.

# Arguments: a single filename generated by jobs -l.

cat $argv[1] | awk '{print $2}' | grep -v '+' | grep -v '-' > /tmp/kill-jobs.$$

set WC_COUNT = `cat /tmp/kill-jobs.$$ | wc -l`
if ($WC_COUNT != 0) then
   foreach j (`cat /tmp/kill-jobs.$$`)
     kill -9 $j
   end
endif

cat $argv[1] | egrep '\+.*Run|\+.*Sus|\-.*Run|\-.*Sus|\+.*Sto|\-.*Sto' | awk '{print $3}' > /tmp/kill-jobs-2.$$
set WC_COUNT = `cat /tmp/kill-jobs-2.$$ | wc -l`
if ($WC_COUNT != 0) then
   foreach j (`cat /tmp/kill-jobs-2.$$`)
     kill -9 $j
   end
endif

rm /tmp/kill-jobs.$$ /tmp/kill-jobs-2.$$
