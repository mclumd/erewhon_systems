#
# Makefile for TRAINS TrueTalk client
#
# George Ferguson, ferguson@cs.rochester.edu, 8 Jan 1996
# Time-stamp: <Thu Jan  9 17:45:53 EST 1997 ferguson>
#

MODULE = SFX

PROG = tsfx
SRCS = main.c input.c recv.c send.c audio.c play.c
HDRS = $(SRCS:.c=.h)
MANS = $(PROG).man
XTRA = 

EXTRA_DEFS = -DDEBUG $(AFDEFS)
EXTRA_LIBS = $(AFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

include config/make.rules.prog

