#
# File:     Makefile
# Directory:libsock
# Created:  1-Sept-1995
# Author:   dbikel

# Remarks:

# COPYRIGHT 1994 BBN Systems and Technologies Corporation
# 70 Fawcett Street
# Cambridge, Ma. 02138
# 617-873-3000
#

# $Header: /tmp_mnt/net/panda/u14/plum/rcs/clibsrc/libsock/Makefile,v 1.14 1997/06/12 21:10:09 dbikel Exp $

include ../make.config

DEPTH =		../..
LIBNAME	=	sock

###
# Define the following two variables to establish where your object files go
# (see definition of Makefile variable ODIR, below)
OROOT =		bin
# All modules that are NOT language-specific should set LANGUAGE to be "all".
LANGUAGE =	all
#
###

### N.B.: You should NOT EVER have to change this definition of $ODIR.
ODIR =	$(OROOT).$(LANGUAGE).${MTYPE}

LDLIBS.sun4os4 = 
LDLIBS.sgirix5 = -none /d4mutl/gnu/lib/gcc-lib/mips-sgi-irix5.2/2.6.3/libgcc.a
LDLIBS.sun4sol = /d4mutl/gnu/lib/gcc-lib/sparc-sun-solaris2.4/2.6.3/libgcc.a
LDLIBS.linux   = /usr/lib/gcc-lib/i486-linux/2.7.2/libgcc.a
LDLIBS = $(LDLIBS.${MTYPE})

LDFLAGS.sun4os4 = -G
LDFLAGS.sgirix5 = -shared -all
LDFLAGS.linux   = -shared
LDFLAGS.sun4sol = -G
LDFLAGS = $(LDFLAGS.${MTYPE})

HEADERS	=	sock.h
OBJECTS =	$(ODIR)/sock.o
SHARED_OBJ =	$(OBJECTS:.o=.fpic)
SOURCES =	sock.c
CC =		gcc

LIBRARIES = 
LDPATH =	-L$(DESTDIR) -L$(ALLDIR)



INTERNAL_CFLAGS =	-g

include ../make.librules

CFLAGS.sgirix4 = $(CFLAGS.common)
CFLAGS.sgirix5 = $(CFLAGS.common)
CFLAGS.sun4os4 = $(CFLAGS.common)
CFLAGS.sun4sol = $(CFLAGS.common) -DSOLARIS
CFLAGS.i686lin = $(CFLAGS.common) -DSOLARIS
CFLAGS = $(CFLAGS.${MTYPE}) -fsigned-char -I- -I. -I../../cinclude

%.o : %.c

$(ODIR)/%.o : %.c
	gmake odir
	$(CC) -o $(ODIR)/$*.o -c $(CFLAGS) $*.c

$(ODIR)/%.fpic : %.c
	gmake odir
	$(CC) -o $(ODIR)/$*.fpic -c $(CFLAGS) -fPIC $*.c

shared: $(SHARED_OBJ)
	ld $(LDFLAGS) -o $(ODIR)/sock.so $(SHARED_OBJ) $(LDLIBS)

%.bin:
		gmake odir
		rm -f $*
		ln -s $(ODIR)/$* $*
		gmake $*
