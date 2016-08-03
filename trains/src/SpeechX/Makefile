#
# Makefile for TRAINS Speech X Display
#
# George Ferguson, ferguson@cs.rochester.edu,  2 Jan 1996
# Time-stamp: <Thu Jan  9 17:47:13 EST 1997 ferguson>
#

MODULE = SpeechX

PROG = tspeechx
SRCS = main.c display.c recv.c send.c utt.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(PROG).man
XTRA =

EXTRA_DEFS =
EXTRA_LIBS = $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_display.c = $(MOTIFDEFS)

include config/make.rules.prog

