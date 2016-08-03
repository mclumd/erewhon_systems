/*
 * drawps.h: Drawing functions for Postscript output
 *
 * George Ferguson, ferguson@cs.rochester.edu,  1 Apr 1995
 * Time-stamp: <95/04/18 15:15:08 ferguson>
 */

#ifndef _drawps_h_gf
#define _drawps_h_gf

#include "point.h"
#include "color.h"
#include "orientation.h"

extern void psOutput(char *filename);

extern void drawPointPS(Color c, int x, int y);
extern void drawLinePS(Color c, int thick, int x1, int y1, int x2, int y2);
extern void drawCirclePS(Color c, int thick, int fill, Color fillcolor,
			 int x, int y, int radius);
extern void drawPolygonPS(Color c, int thick, int fill, Color fillcolor,
			  Point *points, int npoints);
extern void drawArrowPS(Color c, int thick, int x1, int y1, int x2, int y2);
extern void drawArcPS(Color c, int thick,
		      int x1, int y1, int x2, int y2, int r);
extern void drawRectanglePS(Color c, int thick, int fill, Color fillcolor,
			    int x, int y, int w, int h);
extern void drawMultiLinePS(Color c, int thick, Point *points, int npoints);
extern void drawTextPS(Color c, int size, char *txt,
		       int x, int y, Orientation pos);

#endif
