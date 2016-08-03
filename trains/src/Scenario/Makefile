#
# Makefile for TRAINS Scenario Chooser
#
# George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
# Time-stamp: <Fri Jan 10 13:33:19 EST 1997 ferguson>
#

MODULE = Scenario

PROG = tscenario
SRCS = main.c display.c recv.c send.c rc.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(PROG).man
XTRA =

EXTRA_DEFS = 
EXTRA_LIBS = $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_rc.c      = -DTRAINS_BASE=\"$(TRAINS_BASE)\"
EXTRA_DEFS_display.c = $(MOTIFDEFS)

include config/make.rules.prog

install::
	$(CP) scenario.rc $(TRAINS_BASE)/etc
