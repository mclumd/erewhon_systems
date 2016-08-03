#
# Makefile for TRAINS Parse Tree Viewer
#
# George Ferguson, ferguson@cs.rochester.edu, 10 Jan 1997
# Time-stamp: <Mon Jan 20 15:05:56 EST 1997 ferguson>
#

MODULE = PView
SRCS = tpview.pl kqml.perl tree.perl
MANS = tpview.man

include config/make.version
include config/make.defs.$(UNAME)

default:
	@echo 'No need to make.'

install:
	test -d $(TRAINS_BASE)/bin || mkdir $(TRAINS_BASE)/bin
	sed -e '1s@^#!.*$$@#!$(PERL5)@' \
	    -e 's@TRAINS_BASE_DEFAULT =.*$$@TRAINS_BASE_DEFAULT = "$(TRAINS_BASE)";@' \
	    tpview.pl >$(TRAINS_BASE)/bin/tpview
	chmod a+x $(TRAINS_BASE)/bin/tpview
	test -d $(TRAINS_BASE)/etc/pview || mkdir $(TRAINS_BASE)/etc/pview
	$(CP) kqml.perl tree.perl $(TRAINS_BASE)/etc/pview

install.man:
	test -d $(TRAINS_BASE)/man || mkdir $(TRAINS_BASE)/man
	test -d $(TRAINS_BASE)/man/man1 || mkdir $(TRAINS_BASE)/man/man1
	$(CP) tpview.man $(TRAINS_BASE)/man/man1/tpview.1

clean depend:
	@echo 'No need to $@.'

ci:
	test -d RCS || mkdir RCS
	ci -u -t-"" -m"`date`" Makefile $(SRCS) $(MANS) </dev/null
