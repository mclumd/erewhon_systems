#
# Makefile for TRAINS System launch scripts and supporting players
#

MODULE = Running

SRCS = trains.sh trains.noaudio.sh audio_server.sh \
	xtrains xinit.rc twm.rc
MANS = trains.man

include config/make.version
include config/make.defs.$(UNAME)

default:
	@echo 'No need to make.'

install: trains_scripts audio_server_script etc_stuff

trains_scripts:
	test -d $(TRAINS_BASE)/bin || mkdir $(TRAINS_BASE)/bin
	sed 's@^TRAINS_BASE_DEFAULT=.*$$@TRAINS_BASE_DEFAULT=$(TRAINS_BASE)@' trains.sh >$(TRAINS_BASE)/bin/trains
	chmod a+x $(TRAINS_BASE)/bin/trains
	sed 's@^TRAINS_BASE_DEFAULT=.*$$@TRAINS_BASE_DEFAULT=$(TRAINS_BASE)@' trains.noaudio.sh >$(TRAINS_BASE)/bin/trains.noaudio
	chmod a+x $(TRAINS_BASE)/bin/trains.noaudio

audio_server_script:
	test -d $(TRAINS_BASE)/bin || mkdir $(TRAINS_BASE)/bin
	sed 's@^AF_BASE=.*$$@AF_BASE=$(AFBASE)@' audio_server.sh >$(TRAINS_BASE)/bin/audio_server
	chmod a+x $(TRAINS_BASE)/bin/audio_server

etc_stuff:
	test -d $(TRAINS_BASE)/etc || mkdir $(TRAINS_BASE)/etc
	sed 's@^TRAINS_BASE_DEFAULT=.*$$@TRAINS_BASE_DEFAULT=$(TRAINS_BASE)@' xtrains.sh >$(TRAINS_BASE)/etc/xtrains
	chmod a+x $(TRAINS_BASE)/etc/xtrains
	sed 's@^TRAINS_BASE_DEFAULT=.*$$@TRAINS_BASE_DEFAULT=$(TRAINS_BASE)@' xinit.rc >$(TRAINS_BASE)/etc/xinit.rc
	chmod a+x $(TRAINS_BASE)/etc/xinit.rc
	$(CP) twm.rc $(TRAINS_BASE)/etc

install.man:
	test -d $(TRAINS_BASE)/man || mkdir $(TRAINS_BASE)/man
	test -d $(TRAINS_BASE)/man/man1 || mkdir $(TRAINS_BASE)/man/man1
	$(CP) trains.man $(TRAINS_BASE)/man/man1/trains.1

clean depend:
	@echo 'No need to $@.'

ci:
	test -d RCS || mkdir RCS
	ci -u -t-"" -m"`date`" Makefile $(SRCS) $(MANS) </dev/null
