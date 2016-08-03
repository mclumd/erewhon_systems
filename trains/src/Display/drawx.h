/*
 * drawx.h : Drawing functions for X output
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/18 13:22:05 ferguson>
 */

#ifndef _drawx_h_gf
#define _drawx_h_gf

#include "point.h"
#include "color.h"
#include "orientation.h"

extern void drawPointX(Color c, int x, int y);
extern void drawLineX(Color c, int thick, int x1, int y1, int x2, int y2);
extern void drawCircleX(Color c, int thick, int fill, Color fillcolor,
			int x, int y, int radius);
extern void drawPolygonX(Color c, int thick, int fill, Color fillcolor,
			 Point *points, int npoints);
extern void drawArrowX(Color c, int thick, int x1, int y1, int x2, int y2);
extern void drawArcX(Color c, int thick,
		     int x1, int y1, int x2, int y2, int r);
extern void drawRectangleX(Color c, int thick, int fill, Color fillcolor,
			   int x, int y, int w, int h);
extern void drawMultiLineX(Color c, int thick, Point *points, int npoints);
extern void drawTextX(Color c, int size, char *txt,
		      int x, int y, Orientation pos);

#endif
