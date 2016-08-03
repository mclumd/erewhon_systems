#
# Makefile for TRAINS-96 Speech post-processor module
#
# George Ferguson, ferguson@cs.rochester.edu, 10 Jan 1997
# Time-stamp: <Mon Jan 20 15:06:58 EST 1997 ferguson>
#

MODULE = SpeechPP

SRCS = tspeechpp.pl
MANS = tspeechpp.man

include config/make.version
include config/make.defs.$(UNAME)

default:
	@echo 'No need to make'

install:
	test -d $(TRAINS_BASE)/bin || mkdir $(TRAINS_BASE)/bin
	sed -e '1s@^#!.*$$@#!$(PERL5)@' \
	    -e 's@TRAINS_BASE_DEFAULT =.*$$@TRAINS_BASE_DEFAULT = "$(TRAINS_BASE)";@' \
	    tspeechpp.pl >$(TRAINS_BASE)/bin/tspeechpp
	chmod a+x $(TRAINS_BASE)/bin/tspeechpp
	test -d $(TRAINS_BASE)/etc || mkdir $(TRAINS_BASE)/etc
	test -d $(TRAINS_BASE)/etc/SpeechPP || mkdir $(TRAINS_BASE)/etc/SpeechPP
	test -d $(TRAINS_BASE)/etc/SpeechPP/models || mkdir $(TRAINS_BASE)/etc/SpeechPP/models
	$(CP) models/* $(TRAINS_BASE)/etc/SpeechPP/models

install.man:
	test -d $(TRAINS_BASE)/man || mkdir $(TRAINS_BASE)/man
	test -d $(TRAINS_BASE)/man/man1 || mkdir $(TRAINS_BASE)/man/man1
	$(CP) tspeechpp.man $(TRAINS_BASE)/man/man1/tspeechpp.1

clean depend:
	@echo 'No need to $@.'

ci:
	test -d RCS || mkdir RCS
	ci -u -t-"" -m"`date`" Makefile $(SRCS) $(MANS) </dev/null
