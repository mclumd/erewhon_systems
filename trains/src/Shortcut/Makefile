#
# Makefile for TRAINS Shortcut panel
#
# George Ferguson, ferguson@cs.rochester.edu, 22 Mar 1996
# Time-stamp: <Fri Jan 10 13:34:24 EST 1997 ferguson>
#

MODULE = Shortcut

PROG = tshortcut
SRCS = main.c display.c edit.c save.c recv.c send.c rc.c menu_utils.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(PROG).man
XTRA =

EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_rc.c      = -DTRAINS_BASE=\"$(TRAINS_BASE)\"
EXTRA_DEFS_display.c = $(MOTIFDEFS)
EXTRA_DEFS_edit.c    = $(MOTIFDEFS)
EXTRA_DEFS_save.c    = $(MOTIFDEFS)
EXTRA_DEFS_menu_utils.c = $(MOTIFDEFS)

include config/make.rules.prog

install::
	$(CP) shortcut.rc $(TRAINS_BASE)/etc
