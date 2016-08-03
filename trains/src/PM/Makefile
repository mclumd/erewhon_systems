#
# Makefile for TRAINS Process Manager
#
# George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
# Time-stamp: <Thu Jan  9 17:45:38 EST 1997 ferguson>
#

MODULE = PM

PROG = tpm
SRCS = main.c process.c input.c recv.c send.c start.c kill.c im.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(PROG).man
XTRA = 

EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_rc.c = -DTRAINS_BASE=\"$(TRAINS_BASE)\"

include config/make.rules.prog

