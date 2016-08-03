/*
 * shape.c : Shape hierarchy and "member" functions
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Dec 1994
 * Time-stamp: <96/05/09 10:38:13 ferguson>
 *
 * Note: No shapeContains() for ARC or MULTIARC yet.
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <math.h>
#include "shape.h"
#include "draw.h"
#include "color.h"
#include "point.h"
#include "arc.h"
#include "util/error.h"

extern double sqrt(double);

Shape *shapeCreate(ShapeType type,
		   Color color, int thickness, int fill, Color fillcolor, ...);
static LineShape *lineCreate(int x1, int y1, int x2, int y2);
static CircleShape *circleCreate(int x, int y, int radius);
static PolygonShape *polygonCreate(int x, int y, Point *points, int npoints);
static ArcShape *arcCreate(int x1, int y1, int x2, int y2, int r);
static RectangleShape *rectangleCreate(int x, int y, int w, int h);
static MultiLineShape *multiLineCreate(Point *points, int npoints);
static MultiShape *multiCreate(Shape **shapes, int nshapes);

Shape *shapeCopy(Shape *this);

void shapeDestroy(Shape *shape);
static void polygonDestroy(PolygonShape *this);
static void multiLineDestroy(MultiLineShape *this);
static void multiDestroy(MultiShape *this);

void shapeDisplay(Shape *shape);
static void lineDisplay(LineShape *this);
static void circleDisplay(CircleShape *this);
static void polygonDisplay(PolygonShape *this);
static void arrowDisplay(ArrowShape *this);
static void arcDisplay(ArcShape *this);
static void rectangleDisplay(RectangleShape *this);
static void multiLineDisplay(MultiLineShape *this);
static void multiDisplay(MultiShape *this);

int shapeContains(Shape *shape, int x, int y);
static int lineContains(LineShape *this, int x, int y);
static int circleContains(CircleShape *this, int x, int y);
static int polygonContains(PolygonShape *this, int x, int y);
static int rectangleContains(RectangleShape *this, int x, int y);
static int multiLineContains(MultiLineShape *this, int x, int y);
static int multiContains(MultiShape *this, int x, int y);

int shapeLocation(Shape *shape, int *xp, int *yp);

int shapeBoundingBox(Shape *this, int *xp, int *yp, int *wp, int *hp);
static int circleBoundingBox(CircleShape *this,
			     int *xp, int *yp, int *wp, int *hp);
static int polygonBoundingBox(PolygonShape *this,
			      int *xp, int *yp, int *wp, int *hp);
static int multiBoundingBox(MultiShape *this,
			    int *xp, int *yp, int *wp, int *hp);

void shapeSetColor(Shape *this, Color color);
void shapeSetThickness(Shape *this, int thickness);
void shapeSetFill(Shape *this, int fill);
void shapeSetFillColor(Shape *this, Color color);

ShapeType stringToShapeType(char *str);

/*	-	-	-	-	-	-	-	-	*/
/*
 * create
 */

Shape *
shapeCreate(ShapeType type,
	    Color color, int thickness, int fill, Color fillcolor, ...)
{
    Shape *new;
    va_list ap;

    va_start(ap, fillcolor);
    switch (type) {
      case SH_LINE:
      case SH_ARROW: {
	  int x1 = va_arg(ap,int);
	  int y1 = va_arg(ap,int);
	  int x2 = va_arg(ap,int);
	  int y2 = va_arg(ap,int);
	  new = (Shape*)lineCreate(x1,y1,x2,y2);
      } break;
      case SH_CIRCLE: {
	  int x = va_arg(ap,int);
	  int y = va_arg(ap,int);
	  int radius = va_arg(ap,int);
	  new = (Shape*)circleCreate(x,y,radius);
      } break;
      case SH_POLYGON: {
	  int x = va_arg(ap,int);
	  int y = va_arg(ap,int);
	  Point *points = va_arg(ap,Point*);
	  int npoints = va_arg(ap,int);
	  new = (Shape*)polygonCreate(x,y,points,npoints);
      } break;
      case SH_ARC: {
	  int x1 = va_arg(ap,int);
	  int y1 = va_arg(ap,int);
	  int x2 = va_arg(ap,int);
	  int y2 = va_arg(ap,int);
	  int r = va_arg(ap,int);
	  new = (Shape*)arcCreate(x1,y1,x2,y2,r);
      } break;
      case SH_RECTANGLE: {
	  int x = va_arg(ap,int);
	  int y = va_arg(ap,int);
	  int w = va_arg(ap,int);
	  int h = va_arg(ap,int);
	  new = (Shape*)rectangleCreate(x,y,w,h);
      } break;
      case SH_MULTILINE: {
	  Point *points = va_arg(ap,Point*);
	  int npoints = va_arg(ap,int);
	  new = (Shape*)multiLineCreate(points,npoints);
      } break;
      case SH_MULTI: {
	  Shape **shapes = va_arg(ap,Shape**);
	  int nshapes = va_arg(ap,int);
	  new = (Shape*)multiCreate(shapes,nshapes);
      } break;
    }
    va_end(ap);
    if (new) {
	new->any.type = type;
	new->any.color = color;
	new->any.thickness = thickness;
	new->any.fill = fill;
	new->any.fillcolor = fillcolor;
    }
    return new;
}

static LineShape *
lineCreate(int x1, int y1, int x2, int y2)
{
    LineShape *this = (LineShape*)malloc(sizeof(LineShape));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->start.x = x1;
    this->start.y = y1;
    this->end.x = x2;
    this->end.y = y2;
    return this;
}

static CircleShape *
circleCreate(int x, int y, int radius)
{
    CircleShape *this = (CircleShape*)malloc(sizeof(CircleShape));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->center.x = x;
    this->center.y = y;
    this->radius = radius;
    return this;
}

static PolygonShape *
polygonCreate(int x, int y, Point *points, int npoints)
{
    PolygonShape *this = (PolygonShape*)malloc(sizeof(PolygonShape));
    int i;

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->center.x = x;
    this->center.y = y;
    if ((this->points = (Point*)calloc(npoints,sizeof(Point))) == NULL) {
	SYSERR0("points");
	free(this);
	return(NULL);
    }
    for (i=0; i < npoints; i++) {
	this->points[i].x = points[i].x;
	this->points[i].y = points[i].y;
    }
    this->npoints = npoints;
    return this;
}

static ArcShape *
arcCreate(int x1, int y1, int x2, int y2, int r)
{
    ArcShape *this = (ArcShape*)malloc(sizeof(ArcShape));
    int i;

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->start.x = x1;
    this->start.y = y1;
    this->end.x = x2;
    this->end.y = y2;
    this->radius = r;
    return this;
}

static RectangleShape *
rectangleCreate(int x, int y, int w, int h)
{
    RectangleShape *this = (RectangleShape*)malloc(sizeof(RectangleShape));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->start.x = x;
    this->start.y = y;
    this->width = w;
    this->height = h;
    return this;
}

static MultiLineShape *
multiLineCreate(Point *points, int npoints)
{
    MultiLineShape *this = (MultiLineShape*)malloc(sizeof(MultiLineShape));
    int i;

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    if ((this->points = (Point*)calloc(npoints,sizeof(Point))) == NULL) {
	SYSERR0("points");
	free(this);
	return(NULL);
    }
    for (i=0; i < npoints; i++) {
	this->points[i].x = points[i].x;
	this->points[i].y = points[i].y;
    }
    this->npoints = npoints;
    return this;
}

static MultiShape *
multiCreate(Shape **shapes, int nshapes)
{
    MultiShape *this = (MultiShape*)malloc(sizeof(MultiShape));
    int i;

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    if ((this->shapes = (Shape**)calloc(nshapes,sizeof(Shape*))) == NULL) {
	SYSERR0("shapes");
	free((char*)this);
	return NULL;
    }
    for (i=0; i < nshapes; i++) {
	this->shapes[i] = shapes[i];
    }
    this->nshapes = nshapes;
    return this;
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * copy
 */

Shape *
shapeCopy(Shape *this)
{
    Shape *new;

    switch (this->type) {
      case SH_LINE:
	return (Shape*)shapeCreate(SH_LINE,
				   this->line.color,this->line.thickness,
				   this->line.fill, this->line.fillcolor,
				   this->line.start.x, this->line.start.y,
				   this->line.end.x, this->line.end.y);
      case SH_ARROW:
	return (Shape*)shapeCreate(SH_ARROW,
				   this->arrow.color,this->arrow.thickness,
				   this->arrow.fill, this->arrow.fillcolor,
				   this->arrow.start.x, this->arrow.start.y,
				   this->arrow.end.x, this->arrow.end.y);
      case SH_CIRCLE:
	return (Shape*)shapeCreate(SH_CIRCLE,
				   this->circle.color,this->circle.thickness,
				   this->circle.fill, this->circle.fillcolor,
				   this->circle.center.x,
				   this->circle.center.y,
				   this->circle.radius);
      case SH_POLYGON:
	return (Shape*)shapeCreate(SH_POLYGON,
				   this->polygon.color,this->polygon.thickness,
				   this->polygon.fill, this->polygon.fillcolor,
				   this->polygon.center.x,
				   this->polygon.center.y,
				   this->polygon.points,
				   this->polygon.npoints);
      case SH_ARC:
	return (Shape*)shapeCreate(SH_ARC,
				   this->arc.color,this->arc.thickness,
				   this->arc.fill, this->arc.fillcolor,
				   this->arc.start.x, this->arc.start.y,
				   this->arc.end.x, this->arc.end.y,
				   this->arc.radius);
      case SH_RECTANGLE:
	return (Shape*)shapeCreate(SH_RECTANGLE,
				   this->rectangle.color,
				   this->rectangle.thickness,
				   this->rectangle.fill,
				   this->rectangle.fillcolor,
				   this->rectangle.start.x,
				   this->rectangle.start.y,
				   this->rectangle.width,
				   this->rectangle.height);
      case SH_MULTILINE:
	return (Shape*)shapeCreate(SH_MULTILINE,
				   this->multiline.color,
				   this->multiline.thickness,
				   this->multiline.fill,
				   this->multiline.fillcolor,
				   this->multiline.points,
				   this->multiline.npoints);
      case SH_MULTI: {
	  Shape *new;
	  int i;
	  if ((new = shapeCreate(SH_MULTI,
				 this->multi.color,this->multi.thickness,
				 this->multi.fill, this->multi.fillcolor,
				 this->multi.shapes, this->multi.nshapes)) != NULL) {
	      for (i=0; i < new->multi.nshapes; i++) {
		  new->multi.shapes[i] = shapeCopy(this->multi.shapes[i]);
	      }
	  }
	  return new; }
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * destroy
 */

void
shapeDestroy(Shape *this)
{
    if (!this)
	return;
    switch (this->type) {
      case SH_LINE:
      case SH_ARROW:
      case SH_CIRCLE:
      case SH_ARC:
      case SH_RECTANGLE:
	break;
      case SH_POLYGON:
	polygonDestroy((PolygonShape*)this);
	break;
      case SH_MULTILINE:
	multiLineDestroy((MultiLineShape*)this);
	break;
      case SH_MULTI:
	multiDestroy((MultiShape*)this);
	break;
    }
    free((char*)this);
}

static void
polygonDestroy(PolygonShape *this)
{
    if (this->points)
	free((char*)(this->points));
}

static void
multiLineDestroy(MultiLineShape *this)
{
    if (this->points)
	free((char*)(this->points));
}

static void
multiDestroy(MultiShape *this)
{
    int i;

    if (this->shapes) {
	for (i=0; i < this->nshapes; i++) {
	    shapeDestroy(this->shapes[i]);
	}
	free((char*)(this->shapes));
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * display
 */

void
shapeDisplay(Shape *this)
{
    switch (this->type) {
      case SH_LINE:
	lineDisplay((LineShape*)this);
	break;
      case SH_CIRCLE:
	circleDisplay((CircleShape*)this);
	break;
      case SH_POLYGON:
	polygonDisplay((PolygonShape*)this);
	break;
      case SH_ARROW:
	arrowDisplay((ArrowShape*)this);
	break;
      case SH_ARC:
	arcDisplay((ArcShape*)this);
	break;
      case SH_RECTANGLE:
	rectangleDisplay((RectangleShape*)this);
	break;
      case SH_MULTILINE:
	multiLineDisplay((MultiLineShape*)this);
	break;
      case SH_MULTI:
	multiDisplay((MultiShape*)this);
	break;
    }
}

static void
lineDisplay(LineShape *this)
{
    drawLine(this->color,this->thickness,
	     this->start.x,this->start.y,this->end.x,this->end.y);
}

static void
circleDisplay(CircleShape *this)
{
    drawCircle(this->color,this->thickness,
	       this->fill, this->fillcolor,
	       this->center.x,this->center.y,this->radius);
}

static void
polygonDisplay(PolygonShape *this)
{
    drawPolygon(this->color,this->thickness,
		this->fill, this->fillcolor,
		this->points,this->npoints);
}

static void
arrowDisplay(ArrowShape *this)
{
    drawArrow(this->color,this->thickness,
	      this->start.x,this->start.y,this->end.x,this->end.y);
}

static void
arcDisplay(ArcShape *this)
{
    drawArc(this->color,this->thickness,
	    this->start.x,this->start.y,this->end.x,this->end.y,this->radius);
#ifdef undef
    /* Hack to make routes thicker */
    drawArc(this->color,this->thickness,
	    this->start.x,this->start.y,this->end.x,this->end.y,this->radius+1);
#endif
}

static void
rectangleDisplay(RectangleShape *this)
{
    drawRectangle(this->color,this->thickness,
		  this->fill, this->fillcolor,
		  this->start.x,this->start.y,this->width,this->height);
}

static void
multiLineDisplay(MultiLineShape *this)
{
    drawMultiLine(this->color,this->thickness,this->points,this->npoints);
}

static void
multiDisplay(MultiShape *this)
{
    int i;

    for (i=0; i < this->nshapes; i++) {
	shapeDisplay(this->shapes[i]);
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Point-in-shape test
 */

int
shapeContains(Shape *this, int x, int y)
{
    switch (this->type) {
      case SH_LINE:
      case SH_ARROW:
	return lineContains((LineShape*)this, x, y);
      case SH_CIRCLE:
	return circleContains((CircleShape*)this, x, y);
      case SH_POLYGON:
	return polygonContains((PolygonShape*)this, x, y);
      case SH_ARC:
	return 0;		/* not yet, sorry! */
      case SH_RECTANGLE:
	return rectangleContains((RectangleShape*)this, x, y);
      case SH_MULTILINE:
	return multiLineContains((MultiLineShape*)this, x, y);
      case SH_MULTI:
	return multiContains((MultiShape*)this, x, y);
    }
}

static int
lineContains(LineShape *this, int x, int y)
{
    /*
     * CB sez: For line defined by points A and B:
     *  DIST = distance between A and B
     *  CROSS  = C x B in coords centered at A
     *  DOT = C . B in coords centered at A
     * Then for a point C, we have
     *  W = dist from C to AB (ie. length of normal) = CROSS/DIST
     *  V = dist from A to intersection with normal = DOT/DIST
     * NOTE: We need to invert in Y for X11 coordinate system.
     */
    int dx = this->end.x - this->start.x;
    int dy = -(this->end.y - this->start.y);
    int dot = (x - this->start.x)*dx + -(y - this->start.y)*dy;
    int cross = -(y - this->start.y)*dx - (x - this->start.x)*dy;
    float dist = sqrt(dx*dx + dy*dy);
    float v = (float)dot / dist;
    float w = (float)cross / dist;
    return v > 0 && v <= dist &&
	w >= -(this->thickness+1) && w <= this->thickness+1;
}

static int
circleContains(CircleShape *this, int x, int y)
{
    int dx = this->center.x - x;
    int dy = this->center.y - y;
    return sqrt(dx*dx+dy*dy) <= this->radius;
}

static int
polygonContains(PolygonShape *this, int x, int y)
{
    /*
     * This is from the comp.graphics FAQ, apparently due to
     * Wm. Randolph Franklin <wrf@ecse.rpi.edu>, via the FAQ maintainer
     * jdstone@destin.dazixco.ingr.com (Jon Stone).
     */
    int i, j, c = 0;

    for (i = 0, j = this->npoints-1; i < this->npoints; j = i++) {
        if ((((this->points[i].y <= y) && (y < this->points[j].y)) ||
             ((this->points[j].y <= y) && (y < this->points[i].y))) &&
            ((float)x < (this->points[j].x - this->points[i].x) *
	     (float)(y - this->points[i].y) /
	     (float)(this->points[j].y - this->points[i].y) +
	     this->points[i].x))
	    c = !c;
    }
    return c;
}

static int
rectangleContains(RectangleShape *this, int x, int y)
{
    return x >= this->start.x && x <= this->start.x + this->width &&
	y >= this->start.y && y <= this->start.y + this->height;
}

static int
multiLineContains(MultiLineShape *this, int x, int y)
{
    LineShape line;
    int i;

    line.thickness = this->thickness;
    for (i=0; i < this->npoints-1; i++) {
	line.start.x = this->points[i].x;
	line.start.y = this->points[i].y;
	line.end.x = this->points[i+1].x;
	line.end.y = this->points[i+1].y;
	if (lineContains(&line,x,y)) {
	    return 1;
	}
    }
    return 0;
}

static int
multiContains(MultiShape *this, int x, int y)
{
    int i;

    for (i=0; i < this->nshapes; i++) {
	if (shapeContains(this->shapes[i],x,y)) {
	    return 1;
	}
    }
    return 0;
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * "Location" of shape (where meaningful)
 */

int
shapeLocation(Shape *this, int *xp, int *yp)
{
    switch (this->type) {
      case SH_CIRCLE:
	*xp = this->circle.center.x;
	*yp = this->circle.center.y;
	return 1;
      case SH_POLYGON:
	*xp = this->polygon.center.x;
	*yp = this->polygon.center.y;
	return 1;
      case SH_RECTANGLE:
	*xp = this->rectangle.start.x + this->rectangle.width/2;
	*yp = this->rectangle.start.y + this->rectangle.height/2;
	return 1;
      default:
	return 0;
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Bounding Box of shape (where useful)
 */

int
shapeBoundingBox(Shape *this, int *xp, int *yp, int *wp, int *hp)
{
    switch (this->type) {
      case SH_CIRCLE:
	return circleBoundingBox((CircleShape*)this,xp,yp,wp,hp);
      case SH_POLYGON:
	return polygonBoundingBox((PolygonShape*)this,xp,yp,wp,hp);
	break;
      case SH_MULTI:
	return multiBoundingBox((MultiShape*)this,xp,yp,wp,hp);
	break;
      default:
	return 0;
    }
}

static int
circleBoundingBox(CircleShape *this, int *xp, int *yp, int *wp, int *hp)
{
    *xp = this->center.x - this->radius;
    *yp = this->center.y - this->radius;
    *wp = *hp = this->radius * 2;
    return 1;
}
    
static int
polygonBoundingBox(PolygonShape *this, int *xp, int *yp, int *wp, int *hp)
{
    int i,xmin,ymin,xmax,ymax;

    xmin = ymin = 9999;
    xmax = ymax = -1;
    for (i=0; i < this->npoints; i++) {
	if (this->points[i].x < xmin) {
	    xmin = this->points[i].x;
	} else if (this->points[i].x > xmax) {
	    xmax = this->points[i].x;
	}
	if (this->points[i].y < ymin) {
	    ymin = this->points[i].y;
	} else if (this->points[i].y > ymax) {
	    ymax = this->points[i].y;
	}
    }
    *xp = xmin;
    *yp = ymin;
    *wp = xmax - xmin;
    *hp = ymax - ymin;
    return 1;
}

#define MIN(a,b) (((a) < (b)) ? (a) : (b))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

static int
multiBoundingBox(MultiShape *this, int *xp, int *yp, int *wp, int *hp)
{
    int i,x,y,w,h,xmin,ymin,xmax,ymax;

    xmin = ymin = 9999;
    xmax = ymax = -1;
    for (i=0; i < this->nshapes; i++) {
	if (shapeBoundingBox(this->shapes[i],&x,&y,&w,&h)) {
	    xmin = MIN(xmin,x);
	    ymin = MIN(ymin,y);
	    xmax = MAX(xmax,x+w);
	    ymax = MAX(ymax,y+h);
	}
    }
    if (xmax < 0) {
	return 0;
    }
    *xp = xmin;
    *yp = ymin;
    *wp = xmax - xmin;
    *hp = ymax - ymin;
    return 1;
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Set attributes of shapes (special for MULTI)
 */

void
shapeSetColor(Shape *this, Color color)
{
    int i;

    switch (this->type) {
      case SH_MULTI:
	for (i=0; i < this->multi.nshapes; i++) {
	    shapeSetColor(this->multi.shapes[i], color);
	}
	break;
      default:
	this->any.color = color;
    }
}

void
shapeSetThickness(Shape *this, int thickness)
{
    int i;

    switch (this->type) {
      case SH_MULTI:
	for (i=0; i < this->multi.nshapes; i++) {
	    shapeSetThickness(this->multi.shapes[i], thickness);
	}
	break;
      default:
	this->any.thickness = thickness;
    }
}

void
shapeSetFill(Shape *this, int fill)
{
    int i;

    switch (this->type) {
      case SH_MULTI:
	for (i=0; i < this->multi.nshapes; i++) {
	    shapeSetFill(this->multi.shapes[i], fill);
	}
	break;
      default:
	this->any.fill = fill;
    }
}

void
shapeSetFillColor(Shape *this, Color fillcolor)
{
    int i;

    switch (this->type) {
      case SH_MULTI:
	for (i=0; i < this->multi.nshapes; i++) {
	    shapeSetFillColor(this->multi.shapes[i], fillcolor);
	}
	break;
      default:
	this->any.fillcolor = fillcolor;
    }
}

/*	-	-	-	-	-	-	-	-	*/

ShapeType
stringToShapeType(char *str)
{
    if (strcasecmp(str,"LINE") == 0) {
	return SH_LINE;
    } else if (strcasecmp(str,"CIRCLE") == 0) {
	return SH_CIRCLE;
    } else if (strcasecmp(str,"POLYGON") == 0) {
	return SH_POLYGON;
    } else if (strcasecmp(str,"ARROW") == 0) {
	return SH_ARROW;
    } else if (strcasecmp(str,"ARC") == 0) {
	return SH_ARC;
    } else if (strcasecmp(str,"RECTANGLE") == 0) {
	return SH_RECTANGLE;
    } else if (strcasecmp(str,"MULTILINE") == 0) {
	return SH_RECTANGLE;
    } else if (strcasecmp(str,"MULTI") == 0) {
	return SH_MULTI;
    } else {
	return SH_SHAPE;
    }
}
