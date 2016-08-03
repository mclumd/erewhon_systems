#
# Makefile for TRAINS Display v2.0
#
# George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
# Time-stamp: <Tue Jan 14 14:04:42 EST 1997 ferguson>
#
# Need to install maps and bitmaps also!
#

MODULE = Display

PROG = tdisplay
SRCS = main.c recv.c send.c mapfile.c wordbuf.c \
	display.c draw.c drawx.c drawps.c gc.c \
	center.c dialog.c confirm.c mouse.c \
	object.c shape.c point.c color.c highlight.c orientation.c \
	KQML_read.c spline.c
HDRS = $(SRCS:%.c=%.h) displayP.h arc.h
MANS =$(PROG).man
XTRA =

EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(XLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

# These are for profiling...
#CDEBUGFLAGS = -pg
#LDFLAGS = -static

include config/make.rules.prog

EXTRA_DEFS_mapfile.c = -DTRAINS_BASE=\"$(TRAINS_BASE)\"
EXTRA_DEFS_display.c = $(XDEFS)
EXTRA_DEFS_drawx.c   = $(XDEFS)
EXTRA_DEFS_gc.c      = $(XDEFS)
EXTRA_DEFS_center.c  = $(XDEFS)
EXTRA_DEFS_dialog.c  = $(XDEFS)
EXTRA_DEFS_confirm.c = $(XDEFS)
EXTRA_DEFS_mouse.c   = $(XDEFS)
EXTRA_DEFS_color.c   = $(XDEFS)
EXTRA_DEFS_spline.c  = $(XDEFS) -O2

install::
	test -d $(TRAINS_BASE)/etc || mkdir $(TRAINS_BASE)/etc
	test -d $(TRAINS_BASE)/etc/maps || mkdir $(TRAINS_BASE)/etc/maps
	$(CP) maps/* $(TRAINS_BASE)/etc/maps
