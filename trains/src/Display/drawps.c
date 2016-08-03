/*
 * drawps.c : Drawing functions for Postscript output
 *
 * George Ferguson, ferguson@cs.rochester.edu,  1 Apr 1995
 * Time-stamp: <95/04/29 17:16:55 ferguson>
 */
#include <stdio.h>
#include "point.h"
#include "color.h"
#include "orientation.h"
#include "draw.h"
#include "drawps.h"
#include "object.h"				/* for currentObject */
extern double sqrt(double);				/* math.h */

extern int bghack;

/*
 * Functions defined here:
 */
void psOutput(char *filename);
static void psProlog(char *title, int width, int height,
		     float xscale, float yscale);
static void psTrailer();
static void psStartShape(Color c, int thick);
static void psEndShape(int fill, Color fillcolor);

void drawPointPS(Color c, int x, int y);
void drawLinePS(Color c, int thick, int x1, int y1, int x2, int y2);
void drawCirclePS(Color c, int thick, int fill, Color fillcolor,
		  int x, int y, int radius);
void drawPolygonPS(Color c, int thick, int fill, Color fillcolor,
		   Point *points, int npoints);
void drawArrowPS(Color c, int thick, int x1, int y1, int x2, int y2);
void drawArcPS(Color c, int thick,
	       int x1, int y1, int x2, int y2, int r);
void drawRectanglePS(Color c, int thick, int fill, Color fillcolor,
		     int x, int y, int w, int h);
void drawMultiLinePS(Color c, int thick, Point *points, int npoints);
void drawTextPS(Color c, int size, char *txt,
		int x, int y, Orientation pos);

/*
 * Data defined here:
 */
static FILE *psfp;

/*	-	-	-	-	-	-	-	-	*/

void
psOutput(char *filename)
{
    char *name;
    int width, height, xdpi, ydpi;
    float xscale, yscale;

    if ((psfp = fopen(filename, "w")) == NULL) {
	perror(filename);
	return;
    }
    displayGetCanvasAttrs(&name, &width, &height, &xdpi, &ydpi);
    xscale = 72.0 / xdpi;
    yscale = 72.0 / ydpi;
    width *= xscale;
    height *= yscale;
    psProlog(name, width, height, xscale, yscale);
    drawSetDevice(DRAW_PS);
    bghack = 1;
    displayObjects();
    bghack = 0;
    drawSetDevice(DRAW_X);
    psTrailer();
    fclose(psfp);
}

/*	-	-	-	-	-	-	-	-	*/

static void
psProlog(char *title, int width, int height, float xscale, float yscale)
{
    fprintf(psfp, "%%!PS-Adobe-2.0 EPSF-2.0\n");
    fprintf(psfp, "%%%%Title: %s\n", title);
    fprintf(psfp, "%%%%Creator: ttdisplay by George Ferguson\n");
    fprintf(psfp, "%%%%BoundingBox: 0 0 %d %d\n", width, height);
    fprintf(psfp, "%%%%EndComments\n");
    fprintf(psfp, "\n");
    fprintf(psfp, "/TTDict 200 dict def\n");
    fprintf(psfp, "TTDict begin\n");
    fprintf(psfp, " /bd {bind def} bind def\n");
    fprintf(psfp, " /gs {gsave} bd\n");
    fprintf(psfp, " /gr {grestore} bd\n");
    fprintf(psfp, " /n {newpath} bd\n");
    fprintf(psfp, " /m {moveto} bd\n");
    fprintf(psfp, " /l {lineto} bd\n");
    fprintf(psfp, " /rl {rlineto} bd\n");
    fprintf(psfp, " /c {curveto} bd\n");
    fprintf(psfp, " /a {arc} bd\n");
    fprintf(psfp, " /s {stroke} bd\n");
    fprintf(psfp, " /cl {closepath} bd\n");
    fprintf(psfp, " /fi {fill} bd\n");
    fprintf(psfp, " /sc {scale} bd\n");
    fprintf(psfp, " /tr {translate} bd\n");
    fprintf(psfp, " /slw {setlinewidth} bd\n");
    fprintf(psfp, " /srgb {setrgbcolor} bd\n");
    fprintf(psfp, " /left {} bd\n");
    fprintf(psfp, " /center {dup stringwidth pop 2 div neg 0 rmoveto} bd\n");
    fprintf(psfp, " /right {dup stringwidth pop neg 0 rmoveto} bd\n");
    fprintf(psfp, " /xhatch {\n");
    fprintf(psfp, "   clip gs\n");
    fprintf(psfp, "   0 6 7200 {\n");
    fprintf(psfp, "     /cnt exch def\n");
    fprintf(psfp, "     cnt 0 m 7200 7200 cnt sub l s\n");
    fprintf(psfp, "     0 cnt m 7200 cnt sub 7200 l s\n");
    fprintf(psfp, "   } for gr\n");
    fprintf(psfp, " } bd\n");
    fprintf(psfp, "end\n");
    fprintf(psfp, "%%%%EndProlog\n");
    fprintf(psfp, "\n");
    fprintf(psfp, "TTDict begin /TTSavedState save def\n");
    /* This line scales to the resolution of the display and matches the
     * Postscript coordinate system to the X one (reverse Y axis). */
    fprintf(psfp, "0 %d tr %.3f -%.3f sc\n", height, xscale, yscale);
    fprintf(psfp, "\n");
}

static void
psTrailer()
{
    fprintf(psfp, "TTSavedState restore\n");
    fprintf(psfp, "end\n");
}

/*	-	-	-	-	-	-	-	-	*/

static void
psStartShape(Color c, int thick)
{
    int red, green, blue;

    /* This uses a global set in displayObjects() to allow us to have the
     * the object name in the output file. It's kinda gross, but the ps
     * file is a lot more readable with the names there.
     */
    fprintf(psfp, "%% %s %s\n",
	    objectTypeToString(currentObject->type), currentObject->any.name);
    colorToRGB(c, &red, &green, &blue);
    fprintf(psfp, " gs %.3f %.3f %.3f srgb ",
	    red/65535.0, green/65535.0, blue/65535.0);
    if (thick < 0) {
	fprintf(psfp, " 1 slw\n", thick);
    } else {
	fprintf(psfp, " %d slw\n", thick);
    }
    fprintf(psfp, " n ");
}

static void
psEndShape(int fill, Color fillcolor)
{
    int red, green, blue;

    if (fill > 0) {
	/* Filled, set fill color */
	colorToRGB(fillcolor, &red, &green, &blue);
	fprintf(psfp, " gs %.3f %.3f %.3f srgb ",
		red/65535.0, green/65535.0, blue/65535.0);
	if (fill == 100) {
	    /* Solid fill */
	    fprintf(psfp, " fi");
	} else {
	    /* For now, all stipples are just cross-hatched, sorry */
	    fprintf(psfp, " xhatch");
	}
	fprintf(psfp, " gr");
    }
    /* And stroke the path (shape) itself */
    fprintf(psfp, " s gr\n");
}

/*	-	-	-	-	-	-	-	-	*/

void
drawPointPS(Color c, int x, int y)
{
    /* TODO */
}

void
drawLinePS(Color c, int thick, int x1, int y1, int x2, int y2)
{
    psStartShape(c,thick);
    fprintf(psfp, "%d %d m %d %d l", x1, y1, x2, y2);
    psEndShape(0,0);
}

void
drawCirclePS(Color c, int thick, int fill, Color fillcolor,
	     int x, int y, int radius)
{
    psStartShape(c, thick);
    fprintf(psfp, "%d %d %d 0 360 a\n", x, y, radius);
    psEndShape(fill, fillcolor);
}

void
drawPolygonPS(Color c, int thick, int fill, Color fillcolor,
	      Point *points, int npoints)
{
    int i;

    psStartShape(c, thick);
    fprintf(psfp, "%d %d m", points[0].x, points[0].y);
    for (i=1; i < npoints; i++) {
	fprintf(psfp, " %d %d l", points[i].x, points[i].y);
	if (i % 5 == 0) {
	    fprintf(psfp, "\n ");
	}
    }
    fprintf(psfp, " cl\n");
    psEndShape(fill, fillcolor);
}

void
drawArrowPS(Color c, int thick, int x1, int y1, int x2, int y2)
{
    fprintf(psfp, "%%%% couldn't draw arrow from (%d,%d) to (%d,%d)\n",
	    x1, y1, x2, y2);
}

void
drawArcPS(Color c, int thick, int x1, int y1, int x2, int y2, int r)
{
    /* Uses two bezier curves rather than the sampled ellipse in draw.c */
    int dx = x2 - x1;
    int dy = y2 - y1;
    float l = sqrt((double) (dx * dx + dy * dy));
    float sina = dy / l;
    float cosa = dx / l;
    int u = (int)(r * sina + 0.5);
    int v = (int)(r * cosa + 0.5);
    int x3 = x1 + dx/2 - u;
    int y3 = y1 + dy/2 + v;
    int xa, ya, xb, yb;

    psStartShape(c, thick);
    xa = x1 - u/2;
    ya = y1 + v/2;
    xb = x3 + u/2;
    yb = y3 - v/2;
    fprintf(psfp, "%d %d m %d %d %d %d %d %d c\n",
	    x1, y1, xa, ya, xb, yb, x3, y3);
    xa = x3 - u/2;
    ya = y3 + v/2;
    xb = x2 - u/2;
    yb = y2 + v/2;
    fprintf(psfp, "%d %d m %d %d %d %d %d %d c\n",
	    x3, y3, xa, ya, xb, yb, x2, y2);
    psEndShape(0,0);
    {       
	/* Add a little arrow (see draw.c) */
	int ht = 10;
	int wd = 4;
	int xa = x3 + ht * cosa;
	int ya = y3 + ht * sina;
	int xb = x3 - wd * sina;
	int yb = y3 + wd * cosa;
	int xc = x3 + wd * sina;
	int yc = y3 - wd * cosa;
	Point points[4];
	points[0].x = xa; points[0].y = ya;
	points[1].x = xb; points[1].y = yb;
	points[2].x = xc; points[2].y = yc;
	points[3].x = xa; points[3].y = ya;
	drawPolygonPS(c, 1, 100, c, points, 4);
    }
}

void
drawRectanglePS(Color c, int thick, int fill, Color fillcolor,
		int x, int y, int w, int h)
{
    psStartShape(c, thick);
    fprintf(psfp, "%d %d m %d 0 rl 0 %d rl cl\n", x, y, w, h);
    psEndShape(fill, fillcolor);
}

void
drawMultiLinePS(Color c, int thick, Point *points, int npoints)
{
    int i;

    psStartShape(c, thick);
    fprintf(psfp, "%d %d m", points[0].x, points[0].y);
    for (i=1; i < npoints; i++) {
	fprintf(psfp, " %d %d l", points[i].x, points[i].y);
	if (i % 5 == 0) {
	    fprintf(psfp, "\n ");
	}
    }
    if ((i-1) % 5 != 0) {
	fprintf(psfp, "\n");
    }
    psEndShape(0,0);
}

void
drawTextPS(Color c, int size, char *txt, int x, int y, Orientation pos)
{
    int red, green, blue;

    colorToRGB(c, &red, &green, &blue);
    fprintf(psfp, " /Helvetica findfont %d scalefont setfont\n", size);
    fprintf(psfp, " gs %d %d m 1 -1 sc (%s) ", x, y, txt);
    switch (pos) {
      case O_LEFT:
	fprintf(psfp, "left");
	break;
      case O_CENTER:
	fprintf(psfp, "center");
	break;
      case O_RIGHT:
	fprintf(psfp, "right");
	break;
    }
    fprintf(psfp, " %.3f %.3f %.3f srgb show gr\n",
	    red/65535.0, green/65535.0, blue/65535.0);
}
