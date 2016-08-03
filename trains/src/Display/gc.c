/*
 * gc.c : Allocate and maintain a cache of GC's
 *
 * George Ferguson, ferguson@cs.rochester.edu, 10 Jan 1995
 * Time-stamp: <96/05/17 16:00:45 ferguson>
 */

#include <stdio.h>
#include <stdlib.h>
#include <X11/Intrinsic.h>
#include "displayP.h"
#include "color.h"
#include "gc.h"
#undef DEBUG
#include "util/error.h"
#include "util/debug.h"
#include "bitmaps/stipple10.xbm"
#include "bitmaps/stipple20.xbm"
#include "bitmaps/stipple30.xbm"
#include "bitmaps/stipple40.xbm"
#include "bitmaps/stipple50.xbm"
#include "bitmaps/stipple60.xbm"
#include "bitmaps/stipple70.xbm"
#include "bitmaps/stipple80.xbm"
#include "bitmaps/stipple90.xbm"

/*
 * Functions defined here"
 */
GC getGC(Color color, int thickness, int fill);
static void initStipples(void);
GC getTextGC(Color color, int ptsize, XFontStruct **fsp);
void cleanupGCs(void);

static XFontStruct *getFont(int ptsize);

/*
 * Data defined here
 */
typedef struct _GCMap_s {
    Color color;
    int thickness;
    int fill;
    int ptsize;
    XFontStruct *fontstruct;
    GC gc;
    struct _GCMap_s *next;
} GCMap;

static GCMap *gcMap;

static Pixmap stippleBitmaps[10];

/*	-	-	-	-	-	-	-	-	*/

GC
getGC(Color color, int thickness, int fill)
{
    GCMap *p;
    XGCValues values;
    unsigned long mask;

    /* First check the cache for an exact match */
    DEBUG3("color=%ld, thick=%d, fill=%d",color,thickness,fill);
    for (p=gcMap; p != NULL; p=p->next) {
	if (p->color == color &&
	    p->thickness == thickness &&
	    p->fill == fill) {
	    DEBUG0("found in cache");
	    return p->gc;
	}
    }
#ifdef undef
    /* Otherwise check for a gc with no thickness specified yet */
    for (p=gcMap; p != NULL; p=p->next) {
        if (p->color == color && p->thickness == -1) {
            /* Found, so set the thickness and fill and we're done */
            p->thickness = thickness;
            values.line_width = thickness;
            mask = GCLineWidth;
            XChangeGC(display,p->gc,mask,&values);
            return p->gc;
        }
    }
#endif
    /* Not found, allocate a new GC */
    DEBUG0("allocating new gc");
    if ((p = (GCMap*)malloc(sizeof(GCMap))) == NULL) {
	SYSERR0("GCMap");
	return DefaultGCOfScreen(screen);
    }
    /* Set its info */
    p->color = color;
    p->thickness = thickness;
    p->fill = fill;
    p->ptsize = -1;
    p->fontstruct = NULL;
    /* Create the GC */
    values.function = GXcopy;
    values.foreground = color;
    values.line_width = thickness;
    mask = GCFunction | GCForeground | GCLineWidth;
    if (fill > 0) {
	/* If filled, set the fill or stipple pattern */
	DEBUG0("setting fill for gc");
	fill = fill / 10;
	if (fill >= 10) {
	    values.fill_style = FillSolid;
	    mask |= GCFillStyle;
	} else {
	    if (stippleBitmaps[1] == (Pixmap)0) {
		initStipples();
	    }
	    if (fill <= 1) {
		fill = 1;
	    }
	    values.stipple = stippleBitmaps[fill];
	    values.fill_style = FillStippled;
	    mask |= GCStipple | GCFillStyle;
	}
    }
    DEBUG0("creating gc");
    p->gc = XCreateGC(display, canvas, mask, &values);
    /* Add to front of list */
    p->next = gcMap;
    gcMap = p;
    /* Return the GC */
    DEBUG0("done");
    return p->gc;
}

static void
initStipples(void)
{
    stippleBitmaps[1] =
	XCreateBitmapFromData(display,root,stipple10_bits,
			      stipple10_width,stipple10_height);
    stippleBitmaps[2] =
	XCreateBitmapFromData(display,root,stipple20_bits,
			      stipple20_width,stipple20_height);
    stippleBitmaps[3] =
	XCreateBitmapFromData(display,root,stipple30_bits,
			      stipple30_width,stipple30_height);
    stippleBitmaps[4] =
	XCreateBitmapFromData(display,root,stipple40_bits,
			      stipple40_width,stipple40_height);
    stippleBitmaps[5] =
	XCreateBitmapFromData(display,root,stipple50_bits,
			      stipple50_width,stipple50_height);
    stippleBitmaps[6] =
	XCreateBitmapFromData(display,root,stipple60_bits,
			      stipple60_width,stipple60_height);
    stippleBitmaps[7] =
	XCreateBitmapFromData(display,root,stipple70_bits,
			      stipple70_width,stipple70_height);
    stippleBitmaps[8] =
	XCreateBitmapFromData(display,root,stipple80_bits,
			      stipple80_width,stipple80_height);
    stippleBitmaps[9] =
	XCreateBitmapFromData(display,root,stipple90_bits,
			      stipple90_width,stipple90_height);
}

/*	-	-	-	-	-	-	-	-	*/

#define FONTNAMEPAT "-adobe-helvetica-medium-r-*-*-%d-*-*-*-*-*-*-*"
#define DEFAULTFONT "6x10"

static XFontStruct *
getFont(int ptsize)
{
    XFontStruct *fs;
    char name[sizeof(FONTNAMEPAT)+4];

    sprintf(name,FONTNAMEPAT,ptsize);
    if ((fs = XLoadQueryFont(display,name)) == NULL) {
	fprintf(stderr,"display: getFont: couldn't load \"%s\"\n",name); 
	fs = XLoadQueryFont(display,DEFAULTFONT);
    }
    return fs;
}

GC
getTextGC(Color color, int ptsize, XFontStruct **fsp)
{
    GCMap *p;
    XGCValues values;
    unsigned long mask;

    /* First check the cache for an exact match */
    DEBUG2("color=%ld, ptsize=%d",color,ptsize);
    for (p=gcMap; p != NULL; p=p->next) {
	if (p->color == color && p->ptsize == ptsize) {
	    *fsp = p->fontstruct;
	    DEBUG0("found in cache");
	    return p->gc;
	}
    }
    /* Otherwise check for a gc with no ptsize specified yet */
    for (p=gcMap; p != NULL; p=p->next) {
	if (p->color == color && p->ptsize == -1) {
	    /* Found, so set the font and we're done */
	    p->ptsize = ptsize;
	    p->fontstruct = getFont(ptsize);
	    values.font = p->fontstruct->fid;
	    mask = GCFont;
	    XChangeGC(display,p->gc,mask,&values);
	    *fsp = p->fontstruct;
	    DEBUG0("found acceptable gc in cache");
	    return p->gc;
	}
    }
    /* Not found, allocate a new GC */
    DEBUG0("allocating new gc");
    if ((p = (GCMap*)malloc(sizeof(GCMap))) == NULL) {
	SYSERR0("GCMap");
	return DefaultGCOfScreen(screen);
    }
    p->color = color;
    p->thickness = -1;
    p->ptsize = ptsize;
    p->fontstruct = getFont(ptsize);
    values.function = GXcopy;
    values.foreground = color;
    values.font = p->fontstruct->fid;
    mask = GCFunction | GCForeground | GCFont;
    DEBUG0("creating gc");
    p->gc = XCreateGC(display,canvas,mask,&values);
    /* Add to front of list */
    p->next = gcMap;
    gcMap = p;
    /* Return the GC (and the fontstruct) */
    *fsp = p->fontstruct;
    DEBUG0("done");
    return p->gc;
}

/*	-	-	-	-	-	-	-	-	*/

void
cleanupGCs(void)
{
    GCMap *p,*q;

    for (p=gcMap; p != NULL; p=q) {
	q = p;
	XFreeGC(display,p->gc);
	free((char*)p);
    }
}

