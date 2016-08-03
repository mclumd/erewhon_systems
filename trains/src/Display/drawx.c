/*
 * drawx.c : Drawing functions for X oputput
 *
 * George Ferguson, ferguson@cs.rochester.edu, 10 Jan 1995
 * Time-stamp: <96/05/17 17:24:19 ferguson>
 */
#include <stdio.h>
#include <math.h>
#include <X11/Intrinsic.h>
#include "displayP.h"
#include "gc.h"
#include "point.h"
#include "color.h"
#include "orientation.h"
#include "drawx.h"
#include "spline.h"
#undef DEBUG
#include "util/debug.h"

extern double sqrt(double);				/* math.h */

#define ROUND(X)	(int)(((X) < 0.0) ? (X)-.5 : (X)+.5)

/*
 * Functions defined here:
 */
void drawPointX(Color c, int x, int y);
void drawLineX(Color c, int thick, int x1, int y1, int x2, int y2);
void drawCircleX(Color c, int thick, int fill, Color fillcolor,
		 int x, int y, int radius);
void drawPolygonX(Color c, int thick, int fill, Color fillcolor,
		  Point *points, int npoints);
void drawArrowX(Color c, int thick, int x1, int y1, int x2, int y2);
void drawArcX(Color c, int thick, int x1, int y1, int x2, int y2, int r);
void drawRectangleX(Color c, int thick, int fill, Color fillcolor,
		    int x, int y, int w, int h);
void drawMultiLineX(Color c, int thick, Point *points, int npoints);
void drawTextX(Color c, int size, char *txt, int x, int y, Orientation pos);

/*	-	-	-	-	-	-	-	-	*/

void
drawPointX(Color c, int x, int y)
{
    XDrawPoint(display,canvas,getGC(c,0,0),x,y);
}

void
drawLineX(Color c, int thick, int x1, int y1, int x2, int y2)
{
    XDrawLine(display,canvas,getGC(c,thick,0),x1,y1,x2,y2);
}

void
drawCircleX(Color c, int thick, int fill, Color fillcolor,
	    int x, int y, int radius)
{
    /* Draws circle centered at (X,Y), unlike XFillArc... */
    if (fill > 0) {
	XFillArc(display,canvas,getGC(fillcolor,0,fill),
		 x-radius,y-radius,radius*2,radius*2,0,360*64);
    }
    if (thick > 0) {
	XDrawArc(display,canvas,getGC(c,thick,0),
		 x-radius,y-radius,radius*2,radius*2,0,360*64);
    }
}

void
drawPolygonX(Color c, int thick, int fill, Color fillcolor,
	     Point *points, int npoints)
{
    if (fill > 0) {
	XFillPolygon(display,canvas,getGC(fillcolor,0,fill),
		     (XPoint*)points,npoints,Nonconvex,CoordModeOrigin);
    }
    if (thick > 0) {
	XDrawLines(display,canvas,getGC(c,thick,0),
		   (XPoint*)points,npoints,CoordModeOrigin);
    }
}

void
drawArrowX(Color c, int thick, int x1, int y1, int x2, int y2)
{
    int xc, yc, xd, yd, xs, ys, n;
    float x, y, xb, yb, dx, dy, l, sina, cosa;
    float wid = 6.0;
    float  ht = 12.0;
    XPoint points[5];

    XDrawLine(display,canvas,getGC(c,thick,0),x1,y1,x2,y2);
    /* This arrow drawing code snarfed from xfig's draw_arrow() */
    dx = x2 - x1;
    dy = y1 - y2;
    l = sqrt((double) (dx * dx + dy * dy));
    if (l == 0)
        return;
    sina = dy / l;
    cosa = dx / l;
    xb = x2 * cosa - y2 * sina;
    yb = x2 * sina + y2 * cosa;
    /* lengthen the "height" (for an xfig type 2 arrow, which we want) */
    x = xb - ht * 1.2;
    y = yb - wid / 2;
    xc =  x * cosa + y * sina + .5;
    yc = -x * sina + y * cosa + .5;
    y = yb + wid / 2;
    xd =  x * cosa + y * sina + .5;
    yd = -x * sina + y * cosa + .5;
    /* a point "length" from the end of the shaft */
    xs =  (xb-ht) * cosa + yb * sina + .5;
    ys = -(xb-ht) * sina + yb * cosa + .5;
    n = 0;
    points[n].x = xc; points[n++].y = yc;
    points[n].x = x2; points[n++].y = y2;
    points[n].x = xd; points[n++].y = yd;
    points[n].x = xs; points[n++].y = ys;   /* add point on shaft */
    points[n].x = xc; points[n++].y = yc;   /* connect back to original */
    XFillPolygon(display,canvas,getGC(c,1,100),
		 (XPoint*)points,n,Convex,CoordModeOrigin);
}

/*
 * We need to be able to draw an elliptical arc between two arbitrary
 * points (for routes), as opposed to XDrawArc, which draws non-rotated
 * circular or elliptical arcs.
 * This version uses two splines (open, quadratic splines, in fact) with
 * four control points each, taken from the bounding box one of whose
 * edges is the line joining x1,y1 and x2,y2, and which is r units wide
 * perpendicular to that line.
 * This doesn't look too bad, and the resulting spline is typically about
 * seven line segments, which draws much faster than either ellipse algorithm
 * I tried previously.
 * I compute the middle control point, (x3,y3), from the start (x1,y1),
 * end (x2,y2), and radius r. The mid-point is r units along the
 * perpendicular bisector of the line joing the start and end points.
 * NOTE: We add the `arrow' on the route here, since routes are the only
 * use of this arc drawing code. That's a hack.
 */
void
drawArcX(Color c, int thick, int x1, int y1, int x2, int y2, int r)
{
    int x[4], y[4];
    int dx = x2 - x1;
    int dy = -(y2 - y1);
    float l = sqrt((double) (dx * dx + dy * dy));
    /* For `a' = slope of line joining x1,y1 and x2,y2 */
    float sina = dy / l;
    float cosa = dx / l;
    int u = (int)(r * sina + 0.5);
    int v = (int)(r * cosa + 0.5);
    int x3 = x1 + dx/2 - u;
    int y3 = y1 - dy/2 - v;

    DEBUG4("x1=%d, y1=%d, x2=%d, y2=%d", x1, y1, x2, y2);
    DEBUG3("r=%d, u=%d, v=%d", r, u, v);
    DEBUG2("x3=%d, y3=%d", x3, y3);
    /* Setup control points for spline number 1 */
    x[0] = x1;            y[0] = y1;
    x[1] = x1 - u/2;      y[1] = y1 - v/2;
    x[2] = x1 + dx/4 - u; y[2] = y1 - dy/4 - v;
    x[3] = x3;            y[3] = y3;
    DEBUG4("%d,%d, %d,%d", x[0], y[0], x[1], y[1]);
    DEBUG4("%d,%d, %d,%d", x[2], y[2], x[3], y[3]);
    /* Draw spline number 1 */
    Spline(display, canvas, getGC(c,thick,0), x, y, 4);
    /* Setup control points for spline number 2 */
    x[0] = x3;            y[0] = y3;
    x[1] = x2 - dx/4 - u; y[1] = y2 + dy/4 - v;
    x[2] = x2 - u/2;      y[2] = y2 - v/2;
    x[3] = x2;            y[3] = y2;
    /* Draw spline number 2 */
    DEBUG4("%d,%d, %d,%d", x[0], y[0], x[1], y[1]);
    DEBUG4("%d,%d, %d,%d", x[2], y[2], x[3], y[3]);
    Spline(display, canvas, getGC(c,thick,0), x, y, 4);
    /* Add a little arrow (kind of a hack to do it here... */
    {       
	int ht = 10;
	int wd = 4;
	int xa = x3 + ht * cosa;
	int ya = y3 - ht * sina;
	int xb = x3 + wd * sina;
	int yb = y3 + wd * cosa;
	int xc = x3 - wd * sina;
	int yc = y3 - wd * cosa;
	XPoint points[4];
	points[0].x = xa; points[0].y = ya;
	points[1].x = xb; points[1].y = yb;
	points[2].x = xc; points[2].y = yc;
	points[3].x = xa; points[3].y = ya;
	XFillPolygon(display, canvas, getGC(c,thick,0),
		     (XPoint*)points, 4, Convex, CoordModeOrigin);
    }
    DEBUG0("done");
}

void
drawRectangleX(Color c, int thick, int fill, Color fillcolor,
	       int x, int y, int w, int h)
{
    if (fill > 0) {
	XFillRectangle(display,canvas,getGC(fillcolor,0,fill),x,y,w,h);
    }
    if (thick > 0) {
	XDrawRectangle(display,canvas,getGC(c,thick,0),x,y,w,h);
    }
}

void
drawMultiLineX(Color c, int thick, Point *points, int npoints)
{
    XDrawLines(display,canvas,getGC(c,thick,0),
	       (XPoint*)points,npoints,CoordModeOrigin);
}

void
drawTextX(Color c, int size, char *txt, int x, int y, Orientation pos)
{
    GC gc;
    XFontStruct *fs;
    int width;

    gc = getTextGC(c,size,&fs);
    width = XTextWidth(fs,txt,strlen(txt));
    switch (pos) {
      case O_LEFT:
	break;
      case O_CENTER:
	x -= width/2; break;
      case O_RIGHT:
	x -= width; break;
    }
    XDrawString(display,canvas,gc,x,y,txt,strlen(txt));
}
