#
# Makefile for TRAINS Speech (sphinx) v2.0
#
# George Ferguson, ferguson@cs.rochester.edu,  19 Jan 1996
# Time-stamp: <Mon Jan 20 15:06:32 EST 1997 ferguson>
#

MODULE = SpeechIn

PROG = tsphinx
SRCS = sphinx.c init.c utt.c audio.c wordbuf.c input.c recv.c send.c bcast.c
HDRS = $(SRCS:%.c=%.h)
MANS = $(PROG).man
XTRA = tspeech.sh

S2LIBS =  -LSphinx/lib.$(UNAME) -lv8 -lfbsvq_8b -lfe -lad_sun -lmelcep \
		-lcep_manip -lALIGN -lIO -lcommon -lm

CDEBUGFLAGS = -O2
EXTRA_DEFS = 
EXTRA_LIBS = $(S2LIBS) $(AFLIBS) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_audio.c = $(AFDEFS)

include config/make.rules.prog

install::
	test -d $(TRAINS_BASE)/bin || mkdir $(TRAINS_BASE)/bin
	sed 's@!TRAINS_BASE!@$(TRAINS_BASE)@' tspeechin.sh >$(TRAINS_BASE)/bin/tspeechin
	chmod a+x $(TRAINS_BASE)/bin/tspeechin
	#test -d $(TRAINS_BASE)/etc || mkdir $(TRAINS_BASE)/etc
	#test -d $(TRAINS_BASE)/etc/SpeechData || mkdir $(TRAINS_BASE)/etc/SpeechData
	#$(CP) -r SpeechData/* $(TRAINS_BASE)/etc/SpeechData

install.man::
	test -d $(TRAINS_BASE)/man || mkdir $(TRAINS_BASE)/man
	test -d $(TRAINS_BASE)/man/man1 || mkdir $(TRAINS_BASE)/man/man1
	$(CP) tspeechin.man $(TRAINS_BASE)/man/man1/tspeechin.1
