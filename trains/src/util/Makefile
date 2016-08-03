#
# Makefile for TRAINS Utilities library
#
# George Ferguson, ferguson@cs.rochester.edu,  6 Nov 1995
# Time-stamp: <Thu Jan  9 17:35:00 EST 1997 ferguson>
#

MODULE = util

LIB  = libutil
SRCS = buffer.c memory.c 
HDRS = $(SRCS:.c=.h) bitops.h debug.h error.h nonblockio.h streq.h \
	error_codes.h
MANS = $(LIB).man
XTRA = util_timestamp.h

CDEBUGFLAGS = -O2

include config/make.rules.lib

