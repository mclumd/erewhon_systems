#
# Makefile for TRAINS convenience library
#
# George Ferguson, ferguson@cs.rochester.edu,  7 Mar 1996
# Time-stamp: <Thu Jan  9 17:33:48 EST 1997 ferguson>
#

MODULE = trlib

LIB  = libtrlib
SRCS = input.c parse.c error.c send.c debugarg.c hostname.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(LIB).man
XTRA = trlib_timestamp.h

CDEBUGFLAGS = -O2

include config/make.rules.lib

