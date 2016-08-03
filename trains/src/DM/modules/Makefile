#
# Makefile for dm modules
#
# Time-stamp: <Thu Nov  7 15:10:40 EST 1996 ferguson>
#

SUBDIRS = display-manager dm generator kb-lib \
	  reference-resolution speechacts verbal-reasoner world
ci:
	for d in $(SUBDIRS); do \
	    (cd $$d; $(MAKE) ci); \
	done
