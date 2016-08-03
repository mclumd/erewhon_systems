#
# Makefile for TRAINS-96 replay facility
#
# George Ferguson, ferguson@cs.rochester.edu, 10 Jan 1997
# Time-stamp: <Mon Jan 20 15:06:08 EST 1997 ferguson>
#

MODULE = Replay

SRCS = treplay treplay.pl
MANS = treplay.man

include config/make.version
include config/make.defs.$(UNAME)

default:
	@echo 'No need to make'

install:
	test -d $(TRAINS_BASE)/bin || mkdir $(TRAINS_BASE)/bin
	sed -e 's@TRAINS_VERSION=.*$$@TRAINS_VERSION=$(TRAINS_VERSION)@' \
	    -e 's@TRAINS_BASE_DEFAULT=.*$$@TRAINS_BASE_DEFAULT=$(TRAINS_BASE)@' \
	    treplay.sh >$(TRAINS_BASE)/bin/treplay
	chmod a+x $(TRAINS_BASE)/bin/treplay
	sed -e '1s@^#!.*$$@#!$(PERL5)@' \
	    -e 's@TRAINS_BASE_DEFAULT =.*$$@TRAINS_BASE_DEFAULT = "$(TRAINS_BASE)";@' \
	    treplay.pl >$(TRAINS_BASE)/bin/treplay.pl
	chmod a+x $(TRAINS_BASE)/bin/treplay.pl
	test -d $(TRAINS_BASE)/etc || mkdir $(TRAINS_BASE)/etc
	test -d $(TRAINS_BASE)/etc/replay || mkdir $(TRAINS_BASE)/etc/replay
	test -d $(TRAINS_BASE)/etc/replay/bitmaps || mkdir $(TRAINS_BASE)/etc/replay/bitmaps
	$(CP) bitmaps/* $(TRAINS_BASE)/etc/replay/bitmaps

install.man:
	test -d $(TRAINS_BASE)/man || mkdir $(TRAINS_BASE)/man
	test -d $(TRAINS_BASE)/man/man1 || mkdir $(TRAINS_BASE)/man/man1
	$(CP) treplay.man $(TRAINS_BASE)/man/man1/treplay.1

clean depend:
	@echo 'No need to $@.'

ci:
	test -d RCS || mkdir RCS
	ci -u -t-"" -m"`date`" Makefile $(SRCS) $(MANS) </dev/null
