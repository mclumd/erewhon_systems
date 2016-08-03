#!/bin/sh
#
# tparser.sh : This script will load the Parser into a normal Lisp. It can be
#	   used if dumping is impossible or undesirable for some
#	   reason.
#
# George Ferguson, ferguson@cs.rochester.edu,  9 Jan 1997
# Time-stamp: <Tue Jan 14 13:10:52 EST 1997 ferguson>
#
# Note: The setting of *load-verbose* is to prevent file loading
# messages from getting into the KQML stream via *standard-output*.
#

#cl -e '(setq *load-verbose* nil)' \
#   -e "(load \"$TRAINS_BASE/src/Parser/parser.lisp\")" \
#   -e '(PARSER::kqml-parser)

cd $TRAINS_BASE/src/Parser
composer -e '(setq *load-verbose* nil)' \
   -e "(load \"$TRAINS_BASE/src/Parser/parser.lisp\")" \
   -e "(load \"$TRAINS_BASE/src/Parser/parse.lisp\")" \
   -e '(PARSER::kqml-parser)
