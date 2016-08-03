/*
 * VUP.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  4 Jan 1996
 * Time-stamp: <96/08/06 18:18:24 ferguson>
 */

#ifndef _VUP_h_gf
#define _VUP_h_gf

#include "VU.h"
#ifdef MOTIF
# include <Xm/PrimitiveP.h>
#else
# include <X11/Xaw/SimpleP.h>
#endif

typedef struct {
     /* public */
    int	nsegments;		/* number of segments total */
    int	yellowseg;		/* index of first yellow segment */
    int	redseg;			/* index of first red segment */
    int	value;			/* number of segments lit */
    Pixel green;		/* color for "green" segments */
    Pixel yellow;		/* color for "yellow" segments */
    Pixel red;			/* color for "red" segments */
    XtOrientation orientation;	/* horizontal or vertical */
    Dimension length;		/* either height or width */
    Dimension thickness;	/* either width or height */
    Dimension intWidth;
    Dimension intHeight;
    int peakTimeOut;		/* msec for peak indicator (0 => off) */
     /* private */
    GC gc[3];			/* gc's for drawing segments */
    int seght, segwd, seggap;	/* segment sizes derived from dimensions */
    int previous;		/* value at last redraw */
    int peak;			/* latest peak value */
} VUPart;

typedef struct _VURec {
    CorePart		core;
#ifdef MOTIF
    XmPrimitivePart	primitive;
#else
    SimplePart		simple;
#endif
    VUPart		vu;
} VURec;

typedef struct {int empty;} VUClassPart;

typedef struct _VUClassRec {
    CoreClassPart		core_class;
#ifdef MOTIF
    XmPrimitiveClassPart	primitive_class;
#else
    SimpleClassPart		simple_class;
#endif
    VUClassPart			vu_class;
} VUClassRec;

extern VUClassRec vuClassRec;

#endif
