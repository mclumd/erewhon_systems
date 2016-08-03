#!/bin/sh
#
# tdm.sh : This script will load the DM into a normal Lisp. It can be
#	   used if dumping is impossible or undesirable for some
#	   reason.
#
# George Ferguson, ferguson@cs.rochester.edu,  9 Jan 1997
# Time-stamp: <Tue Jan 14 13:11:46 EST 1997 ferguson>
#
# Note: The setting of *load-verbose* is to prevent file loading
# messages from getting into the KQML stream via *standard-output*.
#

cl -e '(setq *load-verbose* nil)' \
   -e "(load \"$TRAINS_BASE/src/DM/dm.lisp\")" \
   -e '(cl-user::toytrains-toplevel)'
