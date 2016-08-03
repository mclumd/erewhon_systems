#
# Makefile for TRAINS Audio Manager
#
# George Ferguson, ferguson@cs.rochester.edu,  2 Jan 1996
# Time-stamp: <Thu Jan  9 17:18:32 EST 1997 ferguson>
#

MODULE = Audio

PROG = taudio
SRCS = main.c display.c VU.c recv.c send.c audio.c
HDRS = $(SRCS:%.c=%.h) VUP.h
MANS = $(PROG).man
XTRA =

EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(AFLIBS) $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_display.c = $(MOTIFDEFS)
EXTRA_DEFS_VU.c      = $(MOTIFDEFS) -DMOTIF
EXTRA_DEFS_audio.c   = $(AFDEFS) $(XDEFS)

include config/make.rules.prog

