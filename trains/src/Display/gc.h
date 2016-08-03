/*
 * gc.h : GC cache functions
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/18 13:33:54 ferguson>
 */

#ifndef _gc_h_gf
#define _gc_h_gf

#include "color.h"

extern GC getGC(Color color, int thickness, int fill);
extern GC getTextGC(Color color, int ptsize, XFontStruct **fsp);
extern void cleanupGCs(void);

#endif
