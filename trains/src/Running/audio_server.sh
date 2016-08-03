#!/bin/sh
#
# audio_server : Do whatever it takes to start an audio server for
#		 TRAINS on the current host
#
# Time-stamp: <Fri Jan 10 14:43:04 EST 1997 ferguson>
#
# Currently, this involves starts the AudioFile server with a sample
# rate of 16000. Note that we should technically be checking for whether
# to run Asparc10 (for the dbri and CS4321 interfaces) or Asparc (for the
# old amd interface). However, since the latter doesn't support a 16000 Hz
# sample rate, we just won't even bother checking.
#

AF_BASE=/u/trains/AF

host=`/bin/uname -n | cut -d. -f1`

(sleep 5; AUDIOFILE=$host:0 $AF_BASE/bin/ahost + >/dev/null) &
exec $AF_BASE/bin/Asparc10 -rate 16000


