#
# Master Makefile for all TRAINS System sources
#
# kpurang removed the SFX thing: no AFlibs
# George Ferguson, ferguson@cs.rochester.edu, 12 Jan 1996
# Time-stamp: <Wed Jan 15 16:31:09 EST 1997 ferguson>
#

LIBDIRS    = config util KQML trlib
MAINDIRS   = IM PM Display Keyboard Running Splash Tools Transcript
#EXTRADIRS  = SFX Shortcut Scenario Replay PView
EXTRADIRS  =  Shortcut Scenario Replay PView
LISPDIRS   = Parser PSM DM
# Comment this out if you don't want speech/audio
#XsSPEECHDIRS = Audio SpeechIn SpeechPP SpeechX SpeechOut
PROGDIRS = $(MAINDIRS) $(EXTRADIRS) $(SPEECHDIRS) $(LISPDIRS)

SUBDIRS =  $(LIBDIRS) $(PROGDIRS)

default:
	@for d in $(SUBDIRS); do \
	  echo "Making in $$d..."; \
	  (cd $$d; $(MAKE)); \
	done

install.man depend clean ci:
	@for d in $(SUBDIRS); do \
	  echo "Making $@ in $$d..."; \
	  (cd $$d; $(MAKE) $@); \
	done

install:
	@for d in $(PROGDIRS); do \
	  echo "Making $@ in $$d..."; \
	  (cd $$d; $(MAKE) $@); \
	done
