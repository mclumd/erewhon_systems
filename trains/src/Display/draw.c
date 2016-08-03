/*
 * draw.c : Device-independent output routines
 *
 * George Ferguson, ferguson@cs.rochester.edu, 10 Jan 1995
 * Time-stamp: <95/04/18 13:20:57 ferguson>
 *
 * This module contains the drawing functions called by the various
 * object display routines. It calls the appropriate routine for the
 * current output mode (eg., X or PS).
 */

#include "point.h"
#include "color.h"
#include "orientation.h"
#include "draw.h"
#include "drawx.h"
#include "drawps.h"

/*
 * Functions defined here:
 */
void drawSetDevice(DrawDevice dev);
void drawPoint(Color c, int x, int y);
void drawLine(Color c, int thick, int x1, int y1, int x2, int y2);
void drawCircle(Color c, int thick, int fill, Color fillcolor,
		int x, int y, int radius);
void drawPolygon(Color c, int thick, int fill, Color fillcolor,
		 Point *points, int npoints);
void drawArrow(Color c, int thick, int x1, int y1, int x2, int y2);
void drawArc(Color c, int thick, int x1, int y1, int x2, int y2, int r);
void drawRectangle(Color c, int thick, int fill, Color fillcolor,
		   int x, int y, int w, int h);
void drawMultiLine(Color c, int thick, Point *points, int npoints);
void drawText(Color c, int size, char *txt, int x, int y, Orientation pos);

/*
 * Data defined here:
 */
static struct _Device_s {
    char *name;
    void (*drawPoint)(Color c, int x, int y);
    void (*drawLine)(Color c, int thick, int x1, int y1, int x2, int y2);
    void (*drawCircle)(Color c, int thick, int fill, Color fillcolor,
		       int x, int y, int radius);
    void (*drawPolygon)(Color c, int thick, int fill, Color fillcolor,
			Point *points, int npoints);
    void (*drawArrow)(Color c, int thick, int x1, int y1, int x2, int y2);
    void (*drawArc)(Color c, int thick, int x1, int y1, int x2, int y2, int r);
    void (*drawRectangle)(Color c, int thick, int fill, Color fillcolor,
			  int x, int y, int w, int h);
    void (*drawMultiLine)(Color c, int thick, Point *points, int npoints);
    void (*drawText)(Color c, int size, char *txt,
		     int x, int y, Orientation pos);
} devices[] = {
    { "X", /* DRAW_X = 0 */
	  drawPointX, drawLineX, drawCircleX, drawPolygonX, drawArrowX,
	  drawArcX, drawRectangleX, drawMultiLineX, drawTextX },
    { "PS", /* DRAW_PS = 1 */
	  drawPointPS, drawLinePS, drawCirclePS, drawPolygonPS, drawArrowPS,
	  drawArcPS, drawRectanglePS, drawMultiLinePS, drawTextPS },
};

static DrawDevice drawDev;

/*	-	-	-	-	-	-	-	-	*/

void
drawSetDevice(DrawDevice dev)
{
    drawDev = dev;
}

/*	-	-	-	-	-	-	-	-	*/

void
drawPoint(Color c, int x, int y)
{
    (*devices[drawDev].drawPoint)(c, x, y);
}

void
drawLine(Color c, int thick, int x1, int y1, int x2, int y2)
{
    (*devices[drawDev].drawLine)(c, thick, x1, y1, x2, y2);
}

void
drawCircle(Color c, int thick, int fill, Color fillcolor,
	   int x, int y, int radius)
{
    (*devices[drawDev].drawCircle)(c, thick, fill, fillcolor, x, y, radius);
}

void
drawPolygon(Color c, int thick, int fill, Color fillcolor,
	    Point *points, int npoints)
{
    (*devices[drawDev].drawPolygon)(c, thick, fill, fillcolor,
				    points, npoints);
}

void
drawArrow(Color c, int thick, int x1, int y1, int x2, int y2)
{
    (*devices[drawDev].drawArrow)(c, thick, x1, y1, x2, y2);
}

void
drawArc(Color c, int thick, int x1, int y1, int x2, int y2, int r)
{
    (*devices[drawDev].drawArc)(c, thick, x1, y1, x2, y2, r);
}

void
drawRectangle(Color c, int thick, int fill, Color fillcolor,
	      int x, int y, int w, int h)
{
    (*devices[drawDev].drawRectangle)(c, thick, fill, fillcolor, x, y, w, h);
}

void
drawMultiLine(Color c, int thick, Point *points, int npoints)
{
    (*devices[drawDev].drawMultiLine)(c, thick, points, npoints);
}

void
drawText(Color c, int size, char *txt, int x, int y, Orientation pos)
{
    (*devices[drawDev].drawText)(c, size, txt, x, y, pos);
}

