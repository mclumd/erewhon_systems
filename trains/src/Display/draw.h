/*
 * draw.h : Drawing functions
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/18 13:21:35 ferguson>
 */

#ifndef _draw_h_gf
#define _draw_h_gf

#include "point.h"
#include "color.h"
#include "orientation.h"

typedef enum {
    DRAW_X = 0,
    DRAW_PS = 1
} DrawDevice;

extern void drawSetDevice(DrawDevice dev);
extern void drawPoint(Color c, int x, int y);
extern void drawLine(Color c, int thick, int x1, int y1, int x2, int y2);
extern void drawCircle(Color c, int thick, int fill, Color fillcolor,
		       int x, int y, int radius);
extern void drawPolygon(Color c, int thick, int fill, Color fillcolor,
			Point *points, int npoints);
extern void drawArrow(Color c, int thick, int x1, int y1, int x2, int y2);
extern void drawArc(Color c, int thick, int x1, int y1, int x2, int y2, int r);
extern void drawRectangle(Color c, int thick, int fill, Color fillcolor,
			  int x, int y, int w, int h);
extern void drawMultiLine(Color c, int thick, Point *points, int npoints);
extern void drawText(Color c, int size, char *txt,
		     int x, int y, Orientation pos);

#endif
