#
# Makefile for TRAINS Keyboard Manager
#
# George Ferguson, ferguson@cs.rochester.edu, 17 Jul 1996
# Time-stamp: <Thu Jan  9 17:45:21 EST 1997 ferguson>
#
#

MODULE = Keyboard

PROG = tkeyboard
SRCS = main.c display.c recv.c send.c wordbuf.c
HDRS = $(SRCS:%.c=%.h)
MANS =$(PROG).man
XTRA =

EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

include config/make.rules.prog

EXTRA_DEFS_display.c = $(MOTIFDEFS)

