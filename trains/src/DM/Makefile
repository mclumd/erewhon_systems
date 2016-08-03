#
# Makefile for TRAINS Discourse Manager
#
# George Ferguson, ferguson@cs.rochester.edu, 13 Dec 1995
# Time-stamp: <Wed Jan 15 16:02:17 EST 1997 ferguson>
#


MODULE = DM

PROG = tdm
HDRS = cl-lib/trains-cl-lib-def.lisp \
	id/logging-def.lisp \
	id/tt-kernel/kqml-library-def.lisp \
	id/tt-simple-kr-def.lisp \
	modules/speechacts/sa-defs-def.lisp \
	lymphocyte/lym-def.lisp \
	modules/kb-lib/kb-lib-def.lisp \
	modules/world-kb/world-kb-def.lisp \
	modules/reference-resolution/user-model-kb-def.lisp \
	modules/display-manager/display-kb-def.lisp \
	modules/generator/self-model-kb-def.lisp \
	modules/reference-resolution/reference-resolution-def.lisp \
	modules/verbal-reasoner/verbal-reasoner-def.lisp \
	modules/generator/generator-def.lisp \
	modules/dm/context-manager-def.lisp \
	modules/dm/discourse-manager-def.lisp \
	modules/display-manager/display-parser-def.lisp \
	id/tt-kernel/hack-def.lisp
SRCS = cl-lib/trains-cl-lib.lisp \
	id/toplevel.lisp \
	modules/speechacts/sa-defs.lisp \
	id/tt-simple-kr.lisp \
	id/tt-kernel/kqml-library.lisp \
	id/logging.lisp \
	lymphocyte/pat-match.lisp \
	lymphocyte/lym-defs.lisp \
	lymphocyte/lym-language.lisp \
	lymphocyte/lym-engine.lisp \
	modules/kb-lib/kb-defs.lisp \
	modules/kb-lib/kb-functions.lisp \
	modules/kb-lib/kb-lib-hack-exports.lisp \
	modules/world-kb/world-kb-defs.lisp \
	modules/world-kb/world-kb.lisp \
	modules/reference-resolution/user-model-kb.lisp \
	modules/display-manager/display-kb-defs.lisp \
	modules/display-manager/display-kb.lisp \
	modules/generator/self-model-kb.lisp \
	modules/reference-resolution/reference-resolution-defs.lisp \
	modules/reference-resolution/path-parser.lisp \
	modules/reference-resolution/ref-rules-support.lisp \
	modules/reference-resolution/ref-rules.lisp \
	modules/reference-resolution/reference-resolution.lisp \
	modules/verbal-reasoner/verbal-reasoner-predefs.lisp \
	modules/verbal-reasoner/verbal-reasoner-defs.lisp \
	modules/verbal-reasoner/verbal-reasoner.lisp \
	modules/verbal-reasoner/prince-ps-interface.lisp \
	modules/verbal-reasoner/vr-lym-support.lisp \
	modules/generator/generator-defs.lisp \
	modules/generator/generator.lisp \
	modules/generator/gen-lym-support.lisp \
	modules/dm/context-manager.lisp \
	modules/dm/discourse-manager.lisp \
	modules/display-manager/display-parser.lisp \
	id/tt-lispmodule.lisp \
	id/tt-kernel/version.lisp \
	id/tt-kernel/x-interface.lisp \
	id/tt-kernel/scoring.lisp \
	id/tt-kernel/world-dump.lisp
XTRA = modules/verbal-reasoner/vr-lym.lisp \
	modules/generator/gen-lym.lisp \
	dump-dm.lisp.lisp
MANS = $(PROG).man

include config/make.rules.dump

install::
	test -d $(TRAINS_BASE)/etc || mkdir $(TRAINS_BASE)/etc
	test -d $(TRAINS_BASE)/etc/scenarios || mkdir $(TRAINS_BASE)/etc/scenarios
	$(CP) scenarios/* $(TRAINS_BASE)/etc/scenarios
