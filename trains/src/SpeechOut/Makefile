#
# Makefile for TRAINS TrueTalk client
#
# George Ferguson, ferguson@cs.rochester.edu, 8 Jan 1996
# Time-stamp: <Mon Jan 20 15:06:49 EST 1997 ferguson>
#

MODULE = SpeechOut

PROG = ttc
SRCS = main.c input.c recv.c send.c truetalk.c audio.c
HDRS = $(SRCS:.c=.h)
MANS = $(PROG).man tts.man tttalk.man
XTRA = tts.sh tttalk.pl

TT_BASE                 = /s7/truetalk/tts.r1.$(UNAME)
TTS_INCS                = -I$(TT_BASE)/h
TTS_LIBS.SunOS.4.1.3_U1 = -L$(TT_BASE)/lib -lttd -lwavesynt
TTS_LIBS.SunOS.5.5.1    = -L$(TT_BASE)/lib -lttd -lwavesynt -lsolaris

CDEBUGFLAGS = -O
EXTRA_DEFS = -DDEBUG
EXTRA_LIBS = $(AFLIBS) $(TTS_LIBS.$(UNAME)) $(TRAINSLIBS)
EXTRA_DEPS = $(TRAINSLIBS)

EXTRA_DEFS_truetalk.c = $(TTS_INCS)
EXTRA_DEFS_audio.c    = $(AFDEFS)

include config/make.rules.prog

install::
	sed -e '1s@^#!.*$$@#!$(PERL)@' \
	    -e 's@TRAINS_BASE_DEFAULT =.*$$@TRAINS_BASE_DEFAULT = "$(TRAINS_BASE)";@' \
	    tspeechout.pl >$(TRAINS_BASE)/bin/tspeechout
	chmod a+x $(TRAINS_BASE)/bin/tspeechout
	$(CP) tts.sh $(TRAINS_BASE)/bin/tts
	chmod a+x $(TRAINS_BASE)/bin/tts

install.man::
	test -d $(TRAINS_BASE)/man || mkdir $(TRAINS_BASE)/man
	test -d $(TRAINS_BASE)/man/man1 || mkdir $(TRAINS_BASE)/man/man1
	$(CP) tspeechout.man $(TRAINS_BASE)/man/man1/tspeechout.1
	$(CP) tts.man $(TRAINS_BASE)/man/man1/tts.1

