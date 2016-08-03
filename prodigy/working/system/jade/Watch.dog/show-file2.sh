#!/usr/local/bin/tcsh -f

# This script merely displays a string until the user quits.
# [cox]

echo $argv[1] "\n"


echo "\n"
echo "\n"
echo "Hit Control-c to exit\n"

while (1)
  # Sleep 1 day, or until user CTRL-C's out.
  sleep 86400
end
