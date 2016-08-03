/*
 * object.c: The object hierarchy and "member" functions
 *
 * George Ferguson, ferguson@cs.rochester.edu, 17 Dec 1994
 * Time-stamp: <96/10/29 09:33:04 ferguson>
 *
 * NOTE: findObjectByName() is currently case-insenstive.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "util/buffer.h"
#include "util/error.h"
#include "object.h"
#include "shape.h"
#include "point.h"
#include "color.h"
#include "orientation.h"
#include "highlight.h"
extern int bghack;

/*
 * Functions defined here:
 */
Object *objectCreate(ObjectType type, char *name,
		     int displayed, int depth, int bg, ...);
static CityObject *cityCreate(Shape *shape,
			      char *label, int ptsize, Orientation textpos);
static TrackObject *trackCreate(CityObject *start, CityObject *end,
				Shape *shape);
static RouteObject *routeCreate(TrackObject **tracks, int ntracks,
				CityObject *start, Color color, int thickness);
static EngineObject *engineCreate(CityObject *atcity, Orientation orientation,
				  int outlined, Shape *shape);
static RegionObject *regionCreate(Shape *shape);

void objectDestroy(Object *obj);
static void cityDestroy(CityObject *this);
static void trackDestroy(TrackObject *this);
static void routeDestroy(RouteObject *this);

void objectDisplay(Object *obj);
static void cityDisplay(CityObject *obj);

int objectContains(Object *obj, int x, int y);
static int trackContains(TrackObject *obj, int x, int y);

int objectLocation(Object *obj, int *xp, int *yp);

Object *findObjectByName(char *name);
Object *findTrackByCities(CityObject *c1, CityObject *c2);
Object *findObjectByCoords(int x, int y, int displayedOnly);
char *findObjectNameByCoords(int x, int y, int displayedOnly);
Object **findObjectsNearCoords(int x, int y, int n, int displayedOnly);

void displayObjects(void);
void destroyObjects(void);

ObjectType stringToObjectType(char *str);
char *objectTypeToString(ObjectType type);

/*
 * Data defined here:
 */
static Object *objectList;
Object *currentObject;

/*	-	-	-	-	-	-	-	-	*/
/*
 * These routines maintain the main list of all objects. The list
 * is maintained in order sorted by depth, for ease of redrawing and
 * searching for mouseclicks (n.b. use of "<=" means that the most recently
 * added object will be found of all objects at the same depth).
 */
static void
enqueueObject(Object *obj)
{
    Object *p,*q;

    if (objectList == NULL || obj->any.depth > objectList->any.depth) {
	/* Deepest so far, insert at head of list */
	obj->any.next = objectList;
	objectList = obj;
    } else {
	/* Else scan for place to insert */
	for (q=p=objectList;
	     p != NULL && obj->any.depth <= p->any.depth;
	     q=p,p=p->any.next) {
	    /*EMPTY*/
	}
	/* Insert in list */
	obj->any.next = q->any.next;
	q->any.next = obj;
    }
}

static void
dequeueObject(Object *obj)
{
    Object *p, *q;

    if (objectList == obj) {
	objectList = obj->any.next;
    } else {
	for (q=p=objectList; p != NULL; q=p,p=p->any.next) {
	    if (p == obj) {
		q->any.next = p->any.next;
		break;
	    }
	}
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * create
 */

Object *
objectCreate(ObjectType type, char *name,
	     int displayed, int depth, int bg, ...)
{
    va_list ap;
    Object *obj;

    va_start(ap,bg);
    switch (type) {
      case OBJ_CITY: {
	  Shape *shape = va_arg(ap,Shape*);
	  char *label = va_arg(ap,char*);
	  int ptsize = va_arg(ap,int);
	  Orientation textpos = va_arg(ap,Orientation);
	  obj = (Object*)cityCreate(shape,label,ptsize,textpos);
      } break;
      case OBJ_TRACK: {
	  CityObject *start = va_arg(ap,CityObject*);
	  CityObject *end = va_arg(ap,CityObject*);
	  Shape *shape = va_arg(ap,Shape*);
	  obj = (Object*)trackCreate(start,end,shape);
      } break;
      case OBJ_ROUTE: {
	  TrackObject **tracks = va_arg(ap,TrackObject**);
	  int ntracks = va_arg(ap,int);
	  CityObject *start = va_arg(ap,CityObject*);
	  Color color = va_arg(ap,Color);
	  int thickness = va_arg(ap,int);
	  obj = (Object*)routeCreate(tracks,ntracks,start,color,thickness);
      }	break;
      case OBJ_TRUCK:
      case OBJ_PLANE:
      case OBJ_ENGINE: {
	  CityObject *atcity = va_arg(ap,CityObject*);
	  Orientation orient = va_arg(ap,Orientation);
	  int outlined = va_arg(ap,int);
	  Shape *shape = va_arg(ap,Shape*);
	  obj = (Object*)engineCreate(atcity,orient,outlined,shape);
      } break;
      case OBJ_REGION: {
	  Shape *shape = va_arg(ap,Shape*);
	  obj = (Object*)regionCreate(shape);
      } break;
    }
    va_end(ap);
    if (obj != NULL) {
	obj->any.type = type;
	if ((obj->any.name = malloc(strlen(name)+1)) == NULL) {
	    SYSERR0("name");
	    objectDestroy(obj);
	    return NULL;
	}
	strcpy(obj->any.name,name);
	obj->any.displayed = displayed;
	obj->any.depth = depth;
	obj->any.bg = bg;
	/* Save color for later unhighlighting (see highlight.c) */
	if (obj->any.shape) {
	    obj->any.color = obj->any.shape->any.color;
	}
	obj->any.highlights = NULL;
	/* Add to global list of objects */
	enqueueObject(obj);
    } else {
	ERROR1("failed to create \"%s\"",name);
    }
    /* Return new object */
    return obj;
}

static CityObject *
cityCreate(Shape *shape, char *label, int ptsize, Orientation textpos)
{
    CityObject *this = (CityObject*)malloc(sizeof(CityObject));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->shape = shape;
    if (label && *label) {
	if ((this->label = malloc(strlen(label)+1)) == NULL) {
	    SYSERR0("label");
	    free((char*)this);
	    return NULL;
	}
	strcpy(this->label,label);
    } else {
	this->label = NULL;
    }
    this->ptsize = ptsize;
    this->textpos = textpos;
    return(this);
}
    
static TrackObject *
trackCreate(CityObject *start, CityObject *end, Shape *shape)
{
    TrackObject *this = (TrackObject*)malloc(sizeof(TrackObject));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->start = start;
    this->end = end;
    this->shape = shape;
    /* And allocate the "map" of routes using this track */
    if ((this->routebuf = bufferCreate()) == NULL) {
	SYSERR0("routebuf");
	free((char*)this);
	return NULL;
    }
    return(this);
}
    
static RouteObject *
routeCreate(TrackObject **tracks, int ntracks, CityObject *start,
	    Color color, int thickness)
{
    RouteObject *this = (RouteObject*)malloc(sizeof(RouteObject));
    CityObject *current,*c1,*c2;
    int i,j,x1,y1,x2,y2,radius;
    RouteObject **routes;
    Shape **shapes;
    int nroutes;

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->tracks = (TrackObject**)calloc(ntracks,sizeof(TrackObject*));
    if (this->tracks == NULL) {
	free((char*)this);
	SYSERR0("tracks");
	return NULL;
    }
    for (i=0; i < ntracks; i++) {
	this->tracks[i] = tracks[i];
    }
    this->ntracks = ntracks;
    this->start = start;
    /* Now create the shape... */
    shapes = (Shape**)calloc(ntracks,sizeof(Shape*));
    if (shapes == NULL) {
	SYSERR0("shapes");
	free((char*)(this->tracks));
	free((char*)this);
	return NULL;
    }
    current = start;
    for (i=0; i < ntracks; i++) {
	/* Get start/end right depending on what direction we're going */
	if (current == tracks[i]->start) {
	    c1 = tracks[i]->start;
	    c2 = tracks[i]->end;
	} else {
	    c1 = tracks[i]->end;
	    c2 = tracks[i]->start;
	}
	objectLocation((Object*)c1,&x1,&y1);
	objectLocation((Object*)c2,&x2,&y2);
	/* Find a free "slot" on the track segment */
	routes = (RouteObject**)bufferData(tracks[i]->routebuf);
	nroutes = bufferDatalen(tracks[i]->routebuf) / sizeof(RouteObject*);
	for (j=0; j < nroutes; j++) {
	    if (routes[j] == NULL) {
		routes[j] = this;
		radius = ((j%2) ? 1 : -1) * (j/2 + 1) * 5;
		/* Also have to flip the radius if we flipped the start/end */
		if (c1 != tracks[i]->start) {
		    radius *= -1;
		}
		break;
	    }
	}
	/* Not found, need to allocate new one */
	if (j == nroutes) {
	    if (bufferAdd(tracks[i]->routebuf, (char*)&this, sizeof(RouteObject*)) < 0) {
		ERROR0("couldn't add to routebuf");
		free((char*)(this->tracks));
		free((char*)this);
		return NULL;
	    }
	    /* This is then exactly the same as above */
	    radius = ((j%2) ? 1 : -1) * (j/2 + 1) * 5;
	    if (c1 != tracks[i]->start) {
		radius *= -1;
	    }
	}
	/* Now we need the arc for this segment of the route */
	shapes[i] = shapeCreate(SH_ARC,color,thickness,0,color,
				x1,y1,x2,y2,radius);
	if (shapes[i] == NULL) {
	    SYSERR0("arc");
	    while (--i >= 0) {
		shapeDestroy(shapes[i]);
	    }
	    free((char*)shapes);
	    free((char*)(this->tracks));
	    free((char*)this);
	    return NULL;
	}
	current = c2;
    }
    this->shape = shapeCreate(SH_MULTI,color,thickness,0,color,shapes,ntracks);
    /* Free the array of pointers but not the shapes themselves */
    free((char*)shapes);
    return(this);
}

static EngineObject *
engineCreate(CityObject *atcity, Orientation orient,
	     int outlined, Shape *shape)
{
    EngineObject *this = (EngineObject*)malloc(sizeof(EngineObject));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->atcity = atcity;
    this->orient = orient;
    this->outlined = outlined;
    this->shape = shape;
    return(this);
}
    
static RegionObject *
regionCreate(Shape *shape)
{
    RegionObject *this = (RegionObject*)malloc(sizeof(RegionObject));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->shape = shape;
    return(this);
}
    
/*	-	-	-	-	-	-	-	-	*/
/*
 * destroy
 */

void
objectDestroy(Object *obj)
{
    if (obj) {
	/* printf("objectDestroy: %s\n",obj->any.name); */
	dequeueObject(obj);
	/* Some objects have special needs */
	switch (obj->type) {
	  case OBJ_CITY:
	    cityDestroy((CityObject*)obj);
	    break;
	  case OBJ_TRACK:
	    trackDestroy((TrackObject*)obj);
	    break;
	  case OBJ_ROUTE:
	    routeDestroy((RouteObject*)obj);
	    break;
	}
	/* All objects do at least this */
	if (obj->any.highlights) {
	    /* This unfortunately will redisplay also... */
	    objectUnhighlight(obj, HI_NONE, NULL, NULL);
	}
	if (obj->any.name)
	    free(obj->any.name);
	if (obj->any.shape)
	    shapeDestroy(obj->any.shape);
	free((char*)obj);
    }
}

static void
cityDestroy(CityObject *this)
{
    if (this->label)
	free(this->label);
}

static void
trackDestroy(TrackObject *this)
{
    if (this->routebuf)
	bufferDestroy(this->routebuf);
}

static void
routeDestroy(RouteObject *this)
{
    RouteObject **routes;
    int nroutes, i, j;

    /* Record that this route is no longer using its tracks */
    for (i=0; i < this->ntracks; i++) {
	routes = (RouteObject**)bufferData(this->tracks[i]->routebuf);
	nroutes = bufferDatalen(this->tracks[i]->routebuf) / sizeof(RouteObject*);
	for (j=0; j < nroutes; j++) {
	    if (routes[j] == this) {
		routes[j] = NULL;
		break;
	    }
	}
    }
    if (this->tracks)
	free((char*)(this->tracks));
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * display
 */

void
objectDisplay(Object *this)
{
    DEBUG1("this=%s", this->any.name);
    if (!this->any.displayed) {
	return;
    }
    if (bghack || !this->any.bg) {
	switch (this->type) {
	  case OBJ_CITY:
	    cityDisplay((CityObject*)this);
	    break;
	  default:
	    if (this->any.shape) {
		shapeDisplay(this->any.shape);
	    }
	}
    }
    if (this->any.highlights) {
	highlightListDisplay(this->any.highlights);
    }
}

static void
cityDisplay(CityObject *this)
{
    static Color black;
    static int blackOK = 0;
    int x,y,w,h;
    Orientation pos;
    char *name;

    shapeDisplay(this->shape);
    shapeBoundingBox(this->shape,&x,&y,&w,&h);
    switch (this->textpos) {
      case O_NORTH:
	x += w/2; pos = O_CENTER; break;
      case O_NORTHEAST:
	x += w/2; pos = O_LEFT; break;
      case O_EAST:
	x += w; y += h/2+this->ptsize/2; pos = O_LEFT; break;
      case O_SOUTHEAST:
	x += w/2; y += h+this->ptsize; pos = O_LEFT; break;
      case O_SOUTH:
	x += w/2; y += h+this->ptsize; pos = O_CENTER; break;
      case O_SOUTHWEST:
	x += w/2; y += h+this->ptsize; pos = O_RIGHT; break;
      case O_WEST:
	y += h/2+this->ptsize/2; pos = O_RIGHT; break;
      case O_NORTHWEST:
	x += w/2; pos = O_RIGHT; break;
    }
#ifdef undef
    /* Use this to have the labels always black */
    if (!blackOK) {
	stringToColor("black",&black);
	blackOK = 1;
    }
    name = this->label ? this->label : this->name;
    drawText(black,this->ptsize,name,x,y,pos);
#else
    name = this->label ? this->label : this->name;
    drawText(this->color,this->ptsize,name,x,y,pos);
#endif
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * point-in-object
 */

int
objectContains(Object *this, int x, int y)
{
    switch (this->type) {
      case OBJ_TRACK:
	return trackContains((TrackObject*)this, x, y);
      default:
	return shapeContains(this->any.shape,x,y);
    }
}

static int
trackContains(TrackObject *this, int x, int y)
{
    return shapeContains(this->shape,x,y) &&
	!objectContains((Object*)(this->start),x,y) &&
	    !objectContains((Object*)(this->end),x,y);
}

/*	-	-	-	-	-	-	-	-	*/

int
objectLocation(Object *this, int *xp, int *yp)
{
    if (this->any.shape) {
	return shapeLocation(this->any.shape,xp,yp);
    } else {
	return 0;
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Object lookup
 */

Object *
findObjectByName(char *name)
{
    Object *p;

    for (p=objectList; p != NULL; p=p->any.next) {
	/* Case-insensitive for Brad, for now... */
	if (p->any.name && strcasecmp(name,p->any.name) == 0) {
	    return p;
	}
    }
    return NULL;
}


Object *
findTrackByCities(CityObject *c1, CityObject *c2)
{
    Object *p;

    for (p=objectList; p != NULL; p=p->any.next) {
        if ((p->track.start == c1 && p->track.end == c2) ||
	    (p->track.start == c2 && p->track.end == c1)) {
            return p;
        }
    }
    return NULL;
}

/*
 * findObjectByCoords: Returns the *least-deep* object containing the
 *	given point. If there's more than one at the same depth, any
 *	of them may be returned (in practice, will find newest).
 *	This could be slightly simplified since objectList is now
 *	maintained in sorted order.
 */
Object *
findObjectByCoords(int x, int y, int displayedOnly)
{
    Object *p, *found;

    found = NULL;
    for (p=objectList; p != NULL; p=p->any.next) {
        if ((!displayedOnly || p->any.displayed) && objectContains(p,x,y)) {
	    if (found == NULL ||  p->any.depth < found->any.depth) {
		found = p;
	    }
        }
    }
    return found;
}

char *
findObjectNameByCoords(int x, int y, int displayedOnly)
{
    Object *obj;

    if ((obj = findObjectByCoords(x, y, displayedOnly)) != NULL) {
	return obj->any.name;
    } else {
	return NULL;
    }
}

Object **
findObjectsNearCoords(int x, int y, int n, int displayedOnly)
{
    static Buffer *objbuf = NULL;
    Object *p;
    int objx,objy,objw,objh,thickness, nobjs;

    if (objbuf == NULL) {
	if ((objbuf = bufferCreate()) == NULL) {
	    SYSERR0("couldn't create objbuf");
	    return NULL;
	}
    }
    bufferErase(objbuf);
    for (p=objectList; p != NULL; p=p->any.next) {
        if ((!displayedOnly || p->any.displayed)) {
	    switch (p->type) {
	      case OBJ_CITY:
	      case OBJ_ENGINE:
	      case OBJ_PLANE:
	      case OBJ_TRUCK:
		if (shapeBoundingBox(p->any.shape,&objx,&objy,&objw,&objh)) {
		    if (!(objx+objw < x-n || x+n < objx) &&
			!(objy+objh < y-n || y+n < objy)) {
			bufferAdd(objbuf, (char*)&p, sizeof(Object*));
		    }
		}
		break;
	      case OBJ_TRACK:
		thickness = p->track.shape->any.thickness;
		p->track.shape->any.thickness = 2*n;
		if (shapeContains(p->track.shape,x,y)) {
		    bufferAdd(objbuf, (char*)&p, sizeof(Object*));
		}
		p->track.shape->any.thickness = thickness;
		break;
	      case OBJ_ROUTE:
		/* can't be located, sorry */
		break;
	    }
	}
    }
    nobjs = bufferDatalen(objbuf) / sizeof(Object*);
    if (nobjs > 0) {
	p = NULL;
	bufferAdd(objbuf, (char*)&p, sizeof(Object*));
	return (Object**)bufferData(objbuf);
    } else {
	return NULL;
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * displayObjects: Draws all the objects in depth order.
 *	This relies on the fact that objectList is maintained in sorted
 *	depth order, deepest first.
 */
void
displayObjects(void)
{
    Object *p;

    for (p=objectList; p != NULL; p=p->any.next) {
	/* Set global variable, currently used only by drawps.c routines */
	currentObject = p;
	objectDisplay(p);
    }
}

void
destroyObjects(void)
{
    Object *p,*q;

    if (!objectList)
	return;
    p = objectList;
    while (p != NULL) {
	q = p->any.next;
	objectDestroy(p);
	p = q;
    }
    objectList = NULL;
}

/*	-	-	-	-	-	-	-	-	*/

ObjectType
stringToObjectType(char *str)
{
    if (strcasecmp(str,"CITY") == 0) {
	return OBJ_CITY;
    } else if (strcasecmp(str,"TRACK") == 0) {
	return OBJ_TRACK;
    } else if (strcasecmp(str,"ROUTE") == 0) {
	return OBJ_ROUTE;
    } else if (strcasecmp(str,"ENGINE") == 0) {
	return OBJ_ENGINE;
    } else if (strcasecmp(str,"PLANE") == 0) {
	return OBJ_PLANE;
    } else if (strcasecmp(str,"TRUCK") == 0) {
	return OBJ_TRUCK;
    } else if (strcasecmp(str,"REGION") == 0) {
	return OBJ_REGION;
    } else {
	return OBJ_OBJECT;
    }
}

char *
objectTypeToString(ObjectType type)
{
    if (type == OBJ_CITY) {
	return "CITY";
    } else if (type == OBJ_TRACK) {
	return "TRACK";
    } else if (type == OBJ_ROUTE) {
	return "ROUTE";
    } else if (type == OBJ_ENGINE) {
	return "ENGINE";
    } else if (type == OBJ_PLANE) {
	return "PLANE";
    } else if (type == OBJ_TRUCK) {
	return "TRUCK";
    } else if (type == OBJ_REGION) {
	return "REGION";
    } else {
	return "OBJECT";
    }
}

