#
# Makefile for TRAINS-96 configuration stuff
#
# George Ferguson, ferguson@cs.rochester.edu, 18 Dec 1995
# Time-stamp: <Wed Jan 15 16:32:02 EST 1997 ferguson>
#

MODULE = config

FILES = Makefile make.version makedepend timestamp.c \
	make.rules.prog make.rules.lib make.rules.dump \
	make.defs.SunOS.4.1.3_U1 \
	make.defs.SunOS.5.5.1 \
	make.defs.OSF1.X3.2

all:
	@echo "Nothing to make"

ci:
	ci -u -t-"" -m"`date`" $(FILES) </dev/null

install install.man clean depend:
	@echo "Nothing to make for $@"

