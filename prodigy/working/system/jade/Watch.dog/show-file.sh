#!/bin/csh -f

# This script merely displays a file until the user quits.

cat $argv[1]

echo ""
echo ""
echo ============================
echo Hit Control-c to exit
echo ============================

while (1)
  # Sleep 1 day, or until user CTRL-C's out.
  sleep 86400
end
