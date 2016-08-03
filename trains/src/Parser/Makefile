#
# Makefile for TRAINS Parser
#
# George Ferguson, ferguson@cs.rochester.edu, 13 Dec 1995
# Time-stamp: <Mon Jan 20 13:26:17 EST 1997 ferguson>
#

MODULE = Parser

PROG = tparser
DEFS = parser/structures.lisp
SRCS = parser/trace.lisp parser/Chart.lisp \
	parser/GrammarandLexicon.lisp parser/FeatureHandling.lisp \
	parser/onlineParser.lisp parser/hierarchFeatures.lisp \
	parser/attachment.lisp parser/hierarchy-functions.lisp \
	parser/lex-functions.lisp parser/char.lisp parser/printing.lisp \
	robust/robustParser.lisp robust/attachments.lisp robust/mouse.lisp \
	robust/kqml.lisp \
	robust/speeling.lisp robust/types.lisp robust/unify.lisp \
	robust/munger.lisp robust/parse.lisp \
	robust/support_funs.lisp robust/questions.lisp
XTRA = grammar/hierarchy.lisp \
	grammar/phrase-grammar.lisp grammar/clause-grammar.lisp\
	grammar/robust.lisp \
	grammar/lexicalRules.lisp \
	grammar/nonverb-lex.lisp grammar/verb-lex.lisp \
	dump-parser.lisp
MANS = $(PROG).man

include config/make.rules.dump

# This target is for James...
all: compile dump install
