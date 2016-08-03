/*
 * VU.h : A simple VU meter widget
 *
 * George Ferguson, ferguson@cs.rochester.edu,  4 Jan 1996
 * Time-stamp: <96/03/08 14:04:09 ferguson>
 */

#ifndef _VU_h_gf
#define _VU_h_gf

#include <X11/Xmu/Converters.h>
#include <X11/Xfuncproto.h>

/* VU resources (aside from those inherited from Simple):

 Name		     Class		RepType		Default Value
 ----		     -----		-------		-------------
 green		     Green		Pixel		green
 internalHeight      Height             Dimension       2
 internalWidth       Width              Dimension       2
 length		     Length		Dimension	1
 nsegments	     Nsegments		Int		15
 orientation	     Orientation	XtOrientation	XtorientVertical
 peakTimeOut	     PeakTimeOut	Int		500 (msec)
 red		     Red		Pixel		red
 redseg		     Redseg		Int		14
 thickness	     Thickness		Dimension	14
 value		     Value		Int		0
 yellow		     Yellow		Pixel		yellow
 yellowseg	     Yellowseg		Int		10
*/

/*
 * Strings not defined in StringDefs.h:
 */
#define XtCNsegments	"Nsegments"
#define XtCYellowSeg	"YellowSeg"
#define XtCRedSeg	"RedSeg"
#define XtCGreen	"Green"
#define XtCYellow	"Yellow"
#define XtCRed		"Red"
#define XtCPeakTimeOut	"PeakTimeOut"

#define XtNnsegments	"nsegments"
#define XtNyellowSeg	"yellowSeg"
#define XtNredSeg	"redSeg"
#define XtNgreen	"green"
#define XtNyellow	"yellow"
#define XtNred		"red"
#define XtNpeakTimeOut	"peakTimeOut"

typedef struct _VURec	  *VUWidget;
typedef struct _VUClassRec *VUWidgetClass;

extern WidgetClass vuWidgetClass;

_XFUNCPROTOBEGIN

extern void VUSetValue(
#if NeedFunctionPrototypes
    Widget	/* vu */,
    int		/* value */
#endif		 
);

_XFUNCPROTOEND

#endif
