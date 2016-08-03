#
# Makefile for TRAINS Input Manager Tools
#
# George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
# Time-stamp: <Mon Jan 20 15:07:14 EST 1997 ferguson>
#

MODULE = Tools

PROGS = tim_msg   tim_cat   tim_client   tim_exec
SRCS  = tim_msg.c tim_cat.c tim_client.c tim_exec.c
HDRS =
MANS = $(PROGS:%=%.man)
XTRA =

EXTRA_DEFS =
EXTRA_LIBS = $(KQMLLIB) $(UTILLIB)
EXTRA_DEPS = $(KQMLLIB) $(UTILLIB)

# Build everything by default
all: $(PROGS)

#
# Stuff snarfed from config/make.rules.prog (which only handles a single prog)
#
include config/make.version
include config/make.defs.$(UNAME)
CFLAGS = $(CDEBUGFLAGS) $(EXTRA_DEFS) $(SPECIAL_DEFS) $(CDEFS)
LIBS   = $(EXTRA_LIBS) $(SPECIAL_LIBS) $(CLIBS)

#
# Build program from corresponding .c
#
$(PROGS):
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ -DTIMESTAMP="\"@(#)$(@) $(TRAINS_VERSION).`cat version` `date`\"" config/timestamp.c $@.c $(LIBS)

#
# Install all programs and manpages
#
install: $(PROGS)
	test -d $(TRAINS_BASE)/bin || mkdir $(TRAINS_BASE)/bin
	$(CP) $(PROGS) $(TRAINS_BASE)/bin

#
# And we have several manpages to install
#
install.man:
	test -d $(TRAINS_BASE)/man || mkdir $(TRAINS_BASE)/man
	test -d $(TRAINS_BASE)/man/man1 || mkdir $(TRAINS_BASE)/man/man1
	@set -x; for f in $(PROGS); do \
	    $(CP) $$f.man $(TRAINS_BASE)/man/man1/$$f.1; \
	done

#
# Clean only executables
#
clean:
	$(RM) $(PROGS)

#
# Depend all sources
#
depend:
	$(MAKEDEPEND) $(SRCS)

#
# Check-in regular stuff
#
ci:
	test -d RCS || mkdir RCS
	ci -u -t-"" -m"`date`" Makefile version $(SRCS) $(HDRS) $(MANS) $(XTRA) </dev/null
