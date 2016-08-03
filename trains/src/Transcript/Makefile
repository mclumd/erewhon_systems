#
# Makefile for TRAINS Transcript module
#
# George Ferguson, ferguson@cs.rochester.edu, 13 Jan 1996
# Time-stamp: <Thu Jan  9 17:47:40 EST 1997 ferguson>
#

MODULE = Transcript

PROG = ttranscript
SRCS = main.c display.c recv.c send.c utt.c log.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(PROG).man
XTRA =

EXTRA_DEFS = 
EXTRA_LIBS = $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_display.c = $(MOTIFDEFS)

include config/make.rules.prog

