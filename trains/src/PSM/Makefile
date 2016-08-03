#
# Makefile for TRAINS PSM (Problem Solver Manager)
#
# George Ferguson, ferguson@cs.rochester.edu, 2 Feb 1996
# Time-stamp: <Mon Jan 20 13:34:49 EST 1997 ferguson>
#

MODULE = PSM

PROG = tpsm
HDRS = structures.lisp
SRCS = PSM.lisp Interface.lisp KB.lisp Task_Tree.lisp \
	constraints.lisp domain_reasoner.lisp kqml.lisp map.lisp \
	route-planner.lisp solutions.lisp
XTRA = dump-psm.lisp
MANS = tpsm.man

include config/make.rules.dump

all: compile dump install
