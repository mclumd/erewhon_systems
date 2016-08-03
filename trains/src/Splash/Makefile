#
# Makefile for TRAINS Splash screen
#
# George Ferguson, ferguson@cs.rochester.edu,  2 Jan 1996
# Time-stamp: <Fri Jan 10 13:36:32 EST 1997 ferguson>
#

MODULE = Splash

PROG = tsplash
SRCS = main.c display.c xpm.c save.c email.c conv.c recv.c send.c logdir.c
HDRS = $(SRCS:%.c=%.h) appres.h
MANS = $(PROG).man
XTRA =

EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(XPMLIBS) $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_main.c    = -DTRAINS_BASE=\"$(TRAINS_BASE)\"
EXTRA_DEFS_display.c = $(MOTIFDEFS) -DTITLE='"TRAINS-96 v$(TRAINS_VERSION)"'
EXTRA_DEFS_save.c    = $(MOTIFDEFS)
EXTRA_DEFS_email.c    = $(MOTIFDEFS)
EXTRA_DEFS_xpm.c     = $(XPMDEFS) $(XDEFS)

include config/make.rules.prog

install::
	$(CP) splash.xpm $(TRAINS_BASE)/etc
