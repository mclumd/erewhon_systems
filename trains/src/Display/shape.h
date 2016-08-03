/*
 * shape.h: Shape hierarchy and "member" functions
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/29 17:15:30 ferguson>
 */

#ifndef _shape_h_gf
#define _shape_h_gf

#include "point.h"
#include "arc.h"
#include "color.h"

typedef enum {
    SH_SHAPE, SH_LINE, SH_CIRCLE, SH_POLYGON, SH_ARROW,
    SH_ARC, SH_RECTANGLE, SH_MULTILINE, SH_MULTI
} ShapeType;

#define SHAPE_COMMON_FIELDS ShapeType type; \
			    Color color; \
			    int thickness; \
			    int fill; \
			    Color fillcolor 

typedef struct _AnyShape_s {
    SHAPE_COMMON_FIELDS;
} AnyShape;

typedef struct _LineShape_s {
    SHAPE_COMMON_FIELDS;
    Point start, end;
} LineShape;

typedef struct _CircleShape_s {
    SHAPE_COMMON_FIELDS;
    Point center;
    int radius;
} CircleShape;

typedef struct _PolygonShape_s {
    SHAPE_COMMON_FIELDS;
    Point center;			/* reference point, anyway */
    Point *points;
    int npoints;
} PolygonShape;

typedef LineShape ArrowShape;

typedef struct _ArcShape_s {
    SHAPE_COMMON_FIELDS;
    Point start;
    Point end;
    int radius;
} ArcShape;
    
typedef struct _RectangleShape_s {
    SHAPE_COMMON_FIELDS;
    Point start;
    int width;
    int height;
} RectangleShape;

typedef struct _MultiLine_s {
    SHAPE_COMMON_FIELDS;
    Point *points;
    int npoints;
} MultiLineShape;

typedef struct _MultiShape_s {
    SHAPE_COMMON_FIELDS;
    union _Shape_u  **shapes;
    int nshapes;
} MultiShape;

typedef union _Shape_u {
    ShapeType type;			/* Must be first */
    AnyShape any;
    LineShape line;
    CircleShape circle;
    PolygonShape polygon;
    ArrowShape arrow;
    ArcShape arc;
    RectangleShape rectangle;
    MultiLineShape multiline;
    MultiShape multi;
} Shape;

extern Shape *shapeCreate(ShapeType type, Color color, int thickness,
			  int fill, Color fillcolor, ...);
extern Shape *shapeCopy(Shape *this);
extern void shapeDestroy(Shape *shape);
extern void shapeDisplay(Shape *shape);
extern int shapeContains(Shape *shape, int x, int y);
extern int shapeLocation(Shape *shape, int *xp, int *yp);
extern int shapeBoundingBox(Shape *shape, int *xp, int *yp, int *wp, int *hp);
extern void shapeSetColor(Shape *this, Color color);
extern void shapeSetThickness(Shape *this, int thickness);
extern void shapeSetFill(Shape *this, int fill);
extern void shapeSetFillColor(Shape *this, Color color);

extern ShapeType stringToShapeType(char *str);

#endif
