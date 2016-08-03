/*
 * object.h: The object hierarchy and "member" functions
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <96/10/29 09:31:45 ferguson>
 */

#ifndef _object_h_gf
#define _object_h_gf

#include "util/buffer.h"
#include "shape.h"
#include "color.h"
#include "orientation.h"

typedef enum {
    OBJ_OBJECT, OBJ_CITY, OBJ_TRACK, OBJ_ROUTE, OBJ_ENGINE, OBJ_PLANE,
    OBJ_REGION,
    OBJ_TRUCK
} ObjectType;

#define OBJECT_COMMON_FIELDS ObjectType type; \
			     char *name; \
			     Shape *shape; \
			     struct _Highlight_s *highlights; \
			     int displayed; \
			     Color color; \
			     int depth; \
			     int bg; \
			     union _Object_u *next

typedef struct _AnyObject_s {
    OBJECT_COMMON_FIELDS;
} AnyObject;
	
typedef struct _CityObject_s {
    OBJECT_COMMON_FIELDS;
    char *label;
    int ptsize;
    Orientation textpos;
} CityObject;

typedef struct _TrackObject_s {
    OBJECT_COMMON_FIELDS;
    CityObject *start; 
    CityObject *end; 
    Buffer *routebuf;
} TrackObject;

typedef struct _RouteObject_s {
    OBJECT_COMMON_FIELDS;
    TrackObject **tracks;
    CityObject *start;
    int ntracks;
} RouteObject;

typedef struct _EngineObject_s {
    OBJECT_COMMON_FIELDS;
    CityObject *atcity;
    Orientation orient;
    int outlined;
} EngineObject;

typedef EngineObject PlaneObject;
typedef EngineObject TruckObject;

typedef struct _RegionObject_s {
    OBJECT_COMMON_FIELDS;
} RegionObject;

typedef union _Object_u {
    ObjectType type;
    AnyObject any;
    CityObject city;
    TrackObject track;
    RouteObject route;
    EngineObject engine;
    PlaneObject plane;
    RegionObject region;
} Object;

extern Object *currentObject;		/* updated during displayObjects */

extern Object *objectCreate(ObjectType type, char *name,
			    int displayed, int depth, int bg, ...);
extern void objectDestroy(Object *obj);
extern void objectDisplay(Object *obj);
extern int objectContains(Object *obj, int x, int y);
extern int objectLocation(Object *obj, int *xp, int *yp);
extern Object *findObjectByName(char *name); /* currently case-insensitive */
extern Object *findTrackByCities(CityObject *c1, CityObject *c2);
extern Object *findObjectByCoords(int x, int y, int displayedOnly);
extern char *findObjectNameByCoords(int x, int y, int displayedOnly);
extern Object **findObjectsNearCoords(int x, int y, int n, int displayedOnly);
extern void displayObjects(void);
extern void destroyObjects(void);
extern ObjectType stringToObjectType(char *str);
extern char *objectTypeToString(ObjectType type);

#endif
