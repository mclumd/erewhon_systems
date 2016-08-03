#
# Makefile for TRAINS Input Manager
#
# George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
# Time-stamp: <Wed Jan 15 16:04:16 EST 1997 ferguson>
#
# To build without the display:
#  - Add -DNO_DISPLAY to EXTRA_DEFS
#  - Remove im_display.c from SRCS
#  - Remove EXTRA_DEFS_im_display.c definition (optional)
#  - Remove XLIBS from EXTRA_LIBS (optional)
#

MODULE = IM

PROG = tim
SRCS = main.c client.c listen.c monitor.c \
	socket.c select.c send.c recv.c bcast.c reply.c \
	input.c output.c accept.c close.c log.c \
	status.c display.c error_codes.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(PROG).man
XTRA =

EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(XPMLIBS) $(MOTIFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_display.c = $(XPMDEFS) $(MOTIFDEFS) -DTRAINS_BASE=\"$(TRAINS_BASE)\"

include config/make.rules.prog

install::
	test -d $(TRAINS_BASE)/etc || mkdir $(TRAINS_BASE)/etc
	$(CP) im_logo.xpm $(TRAINS_BASE)/etc
