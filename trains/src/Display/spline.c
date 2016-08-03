/*
 * spline.c: Spline drawer, ripped from xfig code, whose copyright is below.
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 May 1996
 * Time-stamp: <96/05/10 09:41:03 ferguson>
 */
/*
 * FIG : Facility for Interactive Generation of figures
 * Copyright (c) 1985 by Supoj Sutanthavibul
 * Copyright (c) 1990 by Brian V. Smith
 * Copyright (c) 1992 by James Tough
 *
 * The X Consortium, and any party obtaining a copy of these files from
 * the X Consortium, directly or indirectly, is granted, free of charge, a
 * full and unrestricted irrevocable, world-wide, paid up, royalty-free,
 * nonexclusive right and license to deal in this software and
 * documentation files (the "Software"), including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons who receive
 * copies from any such party to do so, with the only requirement being
 * that this copyright notice remain intact.  This license includes without
 * limitation a license to do the foregoing actions under any patents of
 * the party supplying this software to the X Consortium.
 */
#include <stdio.h>
#include <math.h>
#include <X11/Xlib.h>
#undef DEBUG
#include "util/error.h"
#include "util/debug.h"
#include "spline.h"

#define ROUND(X)	(int)(((X) < 0.0) ? (X)-.5 : (X)+.5)
#define ABS(X)		(((X) > 0) ? (X) : -(X))
#define SIGN(X)		(((X) > 0) ? 1 : -1)

/*
 * Functions defined here:
 */
void Spline(Display *display, Drawable w, GC gc, int *xp, int *yp, int num);
static void quadratic_spline(float a1, float b1, float a2, float b2,
			     float a3, float b3, float a4, float b4);
static void clear_stack(void);
static void push(float x1, float y1, float x2, float y2,
		 float x3, float y3, float x4, float y4);
static int pop(float *x1, float *y1, float *x2, float *y2,
	       float *x3, float *y3, float *x4, float *y4);

/*
 * Data defined here:
 */
#define MAXPTS 1024		/* Gross overkill, probably */
static XPoint points[MAXPTS];
static int npoints;

/* Add a point X,Y to points[] ignoring duplicates */
#define ADD_POINT(X,Y) \
    if (npoints == 0 ||							\
	points[npoints-1].x != (X) || points[npoints-1].y != (Y)) {	\
	    DEBUG3("%3d: %d,%d", npoints, X, Y);			\
	    points[npoints].x = (X);					\
	    points[npoints].y = (Y);					\
	    npoints++;							\
    }

/*	-	-	-	-	-	-	-	-	*/
/*
 * Draws an open spline using the given control points
 */
void
Spline(Display *display, Drawable w, GC gc, int *xp, int *yp, int num)
{
    float cx1, cy1, cx2, cy2, cx3, cy3, cx4, cy4;
    float x1, y1, x2, y2;

    if (num < 2) {
	ERROR1("can't draw spline with %d control points", num);
	return;
    }
    DEBUG1("drawing spline with %d control points", num);
    x1 = xp[0];
    y1 = yp[0];
    x2 = xp[1];
    y2 = yp[1];
    cx1 = (x1 + x2) / 2;
    cy1 = (y1 + y2) / 2;
    cx2 = (cx1 + x2) / 2;
    cy2 = (cy1 + y2) / 2;
    npoints = 0;
    ADD_POINT(ROUND(x1), ROUND(y1));
    num -= 2;
    xp += 2;
    yp += 2;
    while (num--) {
	DEBUG1("num now %d", num);
	x1 = x2;
	y1 = y2;
	x2 = *xp++;
	y2 = *yp++;
	cx4 = (x1 + x2) / 2;
	cy4 = (y1 + y2) / 2;
	cx3 = (x1 + cx4) / 2;
	cy3 = (y1 + cy4) / 2;
	DEBUG0("calling quadratic_spline");
	quadratic_spline(cx1, cy1, cx2, cy2, cx3, cy3, cx4, cy4);
	cx1 = cx4;
	cy1 = cy4;
	cx2 = (cx1 + x2) / 2;
	cy2 = (cy1 + y2) / 2;
    }
    ADD_POINT(ROUND(cx1), ROUND(cy1));
    ADD_POINT(ROUND(x2), ROUND(y2));
    /* Go draw the points */
    DEBUG0("calling XDrawLines...");
    XDrawLines(display, w, gc, points, npoints, CoordModeOrigin);
    /* And free up the array of points */
    free(points);
    DEBUG0("done");

}

/********************* CURVES FOR SPLINES *****************************

	The following spline drawing routine is from

	"An Algorithm for High-Speed Curve Generation"
	by George Merrill Chaikin,
	Computer Graphics and Image Processing, 3, Academic Press,
	1974, 346-349.

	and

	"On Chaikin's Algorithm" by R. F. Riesenfeld,
	Computer Graphics and Image Processing, 4, Academic Press,
	1975, 304-310.

***********************************************************************/

#define		half(z1, z2)	((z1+z2)/2.0)
#define		THRESHOLD	5

/* iterative version */
/*
 * because we draw the spline with small line segments, the style parameter
 * doesn't work
 */

void
quadratic_spline(float a1, float b1, float a2, float b2,
		 float a3, float b3, float a4, float b4)
{
    register float xmid, ymid;
    float x1, y1, x2, y2, x3, y3, x4, y4;

    clear_stack();
    push(a1, b1, a2, b2, a3, b3, a4, b4);
    while (pop(&x1, &y1, &x2, &y2, &x3, &y3, &x4, &y4)) {
	xmid = half(x2, x3);
	ymid = half(y2, y3);
	if (fabs(x1 - xmid) < THRESHOLD && fabs(y1 - ymid) < THRESHOLD &&
	    fabs(xmid - x4) < THRESHOLD && fabs(ymid - y4) < THRESHOLD) {
	    ADD_POINT(ROUND(x1), ROUND(y1));
	    ADD_POINT(ROUND(xmid), ROUND(ymid));
	} else {
	    push(xmid, ymid, half(xmid, x3), half(ymid, y3),
		 half(x3, x4), half(y3, y4), x4, y4);
	    push(x1, y1, half(x1, x2), half(y1, y2),
		 half(x2, xmid), half(y2, ymid), xmid, ymid);
	}
    }
}

/*
 * Utilities used by spline drawing routines
 */

#define	STACK_DEPTH 20

typedef struct _Stack_s {
    float x1, y1, x2, y2, x3, y3, x4, y4;
} Stack;

static Stack stack[STACK_DEPTH];
static Stack *stack_top;
static int stack_count;

void
clear_stack(void)
{
    stack_top = stack;
    stack_count = 0;
}

void
push(float x1, float y1, float x2, float y2,
     float x3, float y3, float x4, float y4)
{
    stack_top->x1 = x1;
    stack_top->y1 = y1;
    stack_top->x2 = x2;
    stack_top->y2 = y2;
    stack_top->x3 = x3;
    stack_top->y3 = y3;
    stack_top->x4 = x4;
    stack_top->y4 = y4;
    stack_top++;
    stack_count++;
}

int
pop(float *x1, float *y1, float *x2, float *y2,
    float *x3, float *y3, float *x4, float *y4)
{
    if (stack_count == 0)
	return (0);
    stack_top--;
    stack_count--;
    *x1 = stack_top->x1;
    *y1 = stack_top->y1;
    *x2 = stack_top->x2;
    *y2 = stack_top->y2;
    *x3 = stack_top->x3;
    *y3 = stack_top->y3;
    *x4 = stack_top->x4;
    *y4 = stack_top->y4;
    return (1);
}
