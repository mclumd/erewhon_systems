/*
 * VU.c : A simple VU meter widget
 *
 * George Ferguson, ferguson@cs.rochester.edu,  4 Jan 1996
 * Time-stamp: <96/08/06 18:37:41 ferguson>
 *
 * Based loosely on the X11R5 Scrollbar widget.
 */
#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#ifdef MOTIF
# include <Xm/PrimitiveP.h>
#else
# include <X11/Xaw/XawInit.h>
#endif
#include <X11/Xmu/Drawing.h>
#include "VUP.h"

#ifdef MOTIF
# define SUPERCLASS_REC	xmPrimitiveClassRec
#else
# define SUPERCLASS_REC	simpleClassRec
#endif

/*
 * Functions defined here:
 */
static void ClassInitialize(void);
static void SetDimensions(VUWidget w);
static void Destroy(Widget w);
static void CreateGCs(Widget w);
static void Initialize(Widget request, Widget new,
		       ArgList args, Cardinal *num_args);
static Boolean SetValues(Widget current, Widget request, Widget new,
			 ArgList args, Cardinal *num_args);
static void Resize(Widget gw);
static void Redisplay(Widget gw, XEvent *event, Region region);
static void PaintMeter(VUWidget w);
static void segmentPosition(VUWidget w, int n, Position *xp, Position *yp);
static GC segmentGC(VUWidget w, int n);
static void peakTimerCB(XtPointer client_data, XtIntervalId *id);
void VUSetValue(Widget gw, int value);

/*
 * Data defined here:
 */
#define Offset(field) XtOffsetOf(VURec, field)
static XtResource resources[] = {
    { XtNorientation, XtCOrientation, XtROrientation, sizeof(XtOrientation),
	  Offset(vu.orientation), XtRImmediate, (XtPointer)XtorientVertical },
    { XtNlength, XtCLength, XtRDimension, sizeof(Dimension),
	  Offset(vu.length), XtRImmediate, (XtPointer)1 },
    { XtNthickness, XtCThickness, XtRDimension, sizeof(Dimension),
	  Offset(vu.thickness), XtRImmediate, (XtPointer)14 },
    { XtNinternalWidth, XtCWidth, XtRDimension,  sizeof(Dimension),
	 Offset(vu.intWidth), XtRImmediate, (XtPointer)2 },
    { XtNinternalHeight, XtCHeight, XtRDimension, sizeof(Dimension),
	 Offset(vu.intHeight), XtRImmediate, (XtPointer)2 },
    { XtNnsegments, XtCNsegments, XtRInt, sizeof(int),
	  Offset(vu.nsegments), XtRImmediate, (XtPointer)15 },
    { XtNyellowSeg, XtCYellowSeg, XtRInt, sizeof(int),
	  Offset(vu.yellowseg), XtRImmediate, (XtPointer)10 },
    { XtNredSeg, XtCRedSeg, XtRInt, sizeof(int),
	  Offset(vu.redseg), XtRImmediate, (XtPointer)14 },
    { XtNvalue, XtCValue, XtRInt, sizeof(int),
	  Offset(vu.value), XtRImmediate, (XtPointer)0 },
    { XtNgreen, XtCGreen, XtRPixel, sizeof(Pixel),
	  Offset(vu.green), XtRString, "green" },
    { XtNyellow, XtCYellow, XtRPixel, sizeof(Pixel),
	  Offset(vu.yellow), XtRString, "yellow" },
    { XtNred, XtCRed, XtRPixel, sizeof(Pixel),
	  Offset(vu.red), XtRString, "red" },
    { XtNpeakTimeOut, XtCPeakTimeOut, XtRInt, sizeof(int),
	  Offset(vu.peakTimeOut), XtRImmediate, (XtPointer)500 },
};
#undef Offset

VUClassRec vuClassRec = {
  { /* core fields */
    /* superclass       */      (WidgetClass) &SUPERCLASS_REC,
    /* class_name       */      "VU",
    /* size             */      sizeof(VURec),
    /* class_initialize	*/	ClassInitialize,
    /* class_part_init  */	NULL,
    /* class_inited	*/	FALSE,
    /* initialize       */      Initialize,
    /* initialize_hook  */	NULL,
    /* realize          */      XtInheritRealize,
    /* actions          */      NULL,
    /* num_actions	*/	0,
    /* resources        */      resources,
    /* num_resources    */      XtNumber(resources),
    /* xrm_class        */      NULLQUARK,
    /* compress_motion	*/	TRUE,
    /* compress_exposure*/	TRUE,
    /* compress_enterleave*/	TRUE,
    /* visible_interest */      FALSE,
    /* destroy          */      Destroy,
    /* resize           */      Resize,
    /* expose           */      Redisplay,
    /* set_values       */      SetValues,
    /* set_values_hook  */	NULL,
    /* set_values_almost */	XtInheritSetValuesAlmost,
    /* get_values_hook  */	NULL,
    /* accept_focus     */      NULL,
    /* version          */	XtVersion,
    /* callback_private */      NULL,
    /* tm_table         */      NULL,
    /* query_geometry	*/	XtInheritQueryGeometry,
    /* display_accelerator*/	XtInheritDisplayAccelerator,
    /* extension        */	NULL
  },
#ifdef MOTIF
  { /* primitive fields */
    /* border_highlight */		XmInheritBorderHighlight,
    /* border_unhighlight */		XmInheritBorderUnhighlight,
    /* translations */			XmInheritTranslations,
    /* arm_and_activate */		XmInheritArmAndActivate,
    /* syn_resources */			NULL,
    /* num_syn_resources */		0,
    /* extension */			NULL,
  },
#else
  { /* simple fields */
    /* change_sensitive         */      XtInheritChangeSensitive
  },
#endif
  { /* vu fields */
    /* ignore                   */      0
  }

};

WidgetClass vuWidgetClass = (WidgetClass)&vuClassRec;

#define GREEN_GC  0
#define YELLOW_GC 1
#define RED_GC	  2

/*	-	-	-	-	-	-	-	-	*/

static void
ClassInitialize(void)
{
#ifndef MOTIF
    XawInitializeWidgetSet();
#endif
    XtAddConverter(XtRString, XtROrientation, XmuCvtStringToOrientation,
		   NULL, (Cardinal)0);
}

static void
SetDimensions(VUWidget w)
{
    /* Set length and thickness from core width and height */
    if (w->vu.orientation == XtorientVertical) {
	w->vu.length = w->core.height;
	w->vu.thickness = w->core.width;
    } else {
	w->vu.length = w->core.width;
	w->vu.thickness = w->core.height;
    }
    /* Compute size of a segment and gap between segments */
    if (w->vu.orientation == XtorientHorizontal) {
	w->vu.segwd = (w->core.width - 2 * w->vu.intWidth) / (w->vu.nsegments + 1);
	w->vu.seght = w->core.height - 2 * w->vu.intHeight;
    } else {
	w->vu.segwd = w->core.width - 2 * w->vu.intWidth;
	w->vu.seght = (w->core.height - 2 * w->vu.intHeight) / (w->vu.nsegments + 1);
    }
    w->vu.seggap = w->vu.segwd / w->vu.nsegments;
    /* Sanity checks */
    if (w->vu.segwd < 1) {
	w->vu.segwd = 1;
    }
    if (w->vu.seght < 1) {
	w->vu.seght = 1;
    }
    if (w->vu.seggap < 1) {
	w->vu.seggap = 1;
    }
}

static void
Destroy(Widget w)
{
    VUWidget vuw = (VUWidget) w;
    
    XtReleaseGC(w, vuw->vu.gc[GREEN_GC]);
    XtReleaseGC(w, vuw->vu.gc[YELLOW_GC]);
    XtReleaseGC(w, vuw->vu.gc[RED_GC]);
}

static void
CreateGCs(Widget w)
{
    VUWidget vuw = (VUWidget) w;
    XGCValues values;
    XtGCMask mask;

    values.background = vuw->core.background_pixel;
    values.fill_style = FillSolid;
    mask = GCForeground | GCBackground | GCFillStyle;
    values.foreground = vuw->vu.green;
    vuw->vu.gc[GREEN_GC] = XtGetGC(w, mask, &values);
    values.foreground = vuw->vu.yellow;
    vuw->vu.gc[YELLOW_GC] = XtGetGC(w, mask, &values);
    values.foreground = vuw->vu.red;
    vuw->vu.gc[RED_GC] = XtGetGC(w, mask, &values);
}

/* ARGSUSED */
static void
Initialize(Widget request, Widget new, ArgList args, Cardinal *num_args)
{
    VUWidget w = (VUWidget) new;

    CreateGCs(new);
    /* Set core size from length and thickness if not given */
    if (w->core.width == 0)
	w->core.width = (w->vu.orientation == XtorientVertical)
	    ? w->vu.thickness : w->vu.length;
    if (w->core.height == 0)
	w->core.height = (w->vu.orientation == XtorientHorizontal)
	    ? w->vu.thickness : w->vu.length;
    /* Compute related dimensions */
    SetDimensions(w);
    /* Initialize rest of widget */
    w->vu.previous = 0;
    w->vu.peak = 0;
}

/* ARGSUSED */
static Boolean 
SetValues(Widget current, Widget request, Widget new,
	  ArgList args, Cardinal *num_args)
{
    VUWidget cw = (VUWidget) current;
    VUWidget nw = (VUWidget) new;
    Boolean redraw = FALSE;

    /* Sanity check */
    if (nw->vu.value < 0 || nw->vu.value > nw->vu.nsegments) {
        nw->vu.value = cw->vu.value;
    }
    /* Handle changes */
    if (XtIsRealized(new)) {
	if ((cw->vu.green != nw->vu.green) ||
	    (cw->vu.yellow != nw->vu.yellow) ||
	    (cw->vu.red != nw->vu.red)) {
	    XtReleaseGC((Widget)nw, cw->vu.gc[GREEN_GC]); /* really cw??? */
	    XtReleaseGC((Widget)nw, cw->vu.gc[YELLOW_GC]);
	    XtReleaseGC((Widget)nw, cw->vu.gc[RED_GC]);
	    CreateGCs((Widget)nw);
	    redraw = TRUE;
	}
	if (cw->vu.orientation != nw->vu.orientation) {
	    SetDimensions(nw);
	    redraw = TRUE;
	}
	if (cw->vu.nsegments != nw->vu.nsegments ||
	    cw->vu.value != nw->vu.value)
	    redraw = TRUE;
    }
    /* Redraw if needed */
    return(redraw);
}

static void
Resize(Widget gw)
{
    VUWidget w = (VUWidget) gw;

    SetDimensions(w);
    Redisplay(gw, (XEvent*)NULL, (Region)NULL);
}

/* ARGSUSED */
static void
Redisplay(Widget gw, XEvent *event, Region region)
{
    VUWidget w = (VUWidget) gw;

    if (!XtIsRealized(gw)) {
	return;
    }
    /* No point being smart about the region here */
    XClearWindow(XtDisplay(w), XtWindow(w));
    /* Force redraw of entire meter */
    w->vu.previous = 0;
    PaintMeter(w);
}

static void
PaintMeter(VUWidget w)
{
    Position x, y;
    int i, first, last;
    Boolean draw;

    /* Nothing to do until realized */
    if (!XtIsRealized((Widget)w)) {
	return;
    }
    if (w->vu.value == w->vu.previous) {
	return;
    }
    /* Determine whether to draw or clear, and which segments */
    if (w->vu.value > w->vu.previous) {
	/* Value increased: draw new segments */
	first = w->vu.previous+1;
	last = w->vu.value;
	draw = TRUE;
    } else {
	/* Value decreased: clear old segments */
	first = w->vu.value+1;
	last = w->vu.previous;
	draw = FALSE;
    }
    w->vu.previous = w->vu.value;
    /* Draw or clear segments */
    for (i=first; i <= last; i++) {
	/* Compute position of this segment */
	segmentPosition(w, i, &x, &y);
	/* Draw or clear segment */
	if (draw) {
	    XFillRectangle(XtDisplay(w), XtWindow(w), segmentGC(w, i),
			   x, y, w->vu.segwd, w->vu.seght);
	} else {
	    XClearArea(XtDisplay(w), XtWindow(w),
		       x, y, w->vu.segwd, w->vu.seght, FALSE);
	}
    }
    /* If we're using the peak indicator... */
    if (w->vu.peakTimeOut > 0) {
	/* If we have a new peak, record it, otherwise draw peak */
	if (draw && w->vu.value > w->vu.peak) {
	    w->vu.peak = w->vu.value;
	    XtAppAddTimeOut(XtWidgetToApplicationContext((Widget)w),
			    w->vu.peakTimeOut, peakTimerCB, (XtPointer)w);
	} else if (w->vu.peak > 0) {
	    /* Compute position of peak segment */
	    segmentPosition(w, w->vu.peak, &x, &y);
	    /* Draw peak segment */
	    XFillRectangle(XtDisplay(w), XtWindow(w), segmentGC(w, w->vu.peak),
			   x, y, w->vu.segwd, w->vu.seght);
	}
    }
}

static void
segmentPosition(VUWidget w, int n, Position *xp, Position *yp)
{
    if (w->vu.orientation == XtorientHorizontal) {
	*xp = w->vu.intWidth + (n - 1) * (w->vu.segwd + w->vu.seggap);
	*yp = w->vu.intHeight;
    } else {
	*yp = w->core.height - w->vu.intHeight - (n * (w->vu.seght + w->vu.seggap));
	*xp = w->vu.intWidth;
    }
}

static GC
segmentGC(VUWidget w, int n)
{
    /* Select gc based on segment number */
    if (n < w->vu.yellowseg) {
	return w->vu.gc[GREEN_GC];
    } else if (n < w->vu.redseg) {
	return w->vu.gc[YELLOW_GC];
    } else {
	return w->vu.gc[RED_GC];
    }
}

static void
peakTimerCB(XtPointer client_data, XtIntervalId *id)
{
    VUWidget w = (VUWidget)client_data;
    Position x, y;

    if (w->vu.value < w->vu.peak) {
	/* Compute size of a segment */
	segmentPosition(w, w->vu.peak, &x, &y);
	/* Clear the segment */
	XClearArea(XtDisplay(w), XtWindow(w),
		   x, y, w->vu.segwd, w->vu.seght, FALSE);
    }
    w->vu.peak = 0;
}
	

/*	-	-	-	-	-	-	-	-	*/
/*
 * Public functions:
 */

void
VUSetValue(Widget gw, int value)
{
    VUWidget w = (VUWidget)gw;

    if (value < 0) {
	w->vu.value = 0;
    } else if (value > w->vu.nsegments) {
	w->vu.value = w->vu.nsegments;
    } else {
	w->vu.value = value;
    }
    PaintMeter(w);
}
