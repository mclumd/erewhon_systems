/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Apr 1996
 * Time-stamp: <96/10/29 10:05:39 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/memory.h"
#include "util/streq.h"
#include "util/error.h"
#include "util/debug.h"
#include "recv.h"
#include "display.h"
#include "main.h"
#include "object.h"
#include "point.h"
#include "color.h"
#include "orientation.h"
#include "highlight.h"
#include "drawps.h"
#include "confirm.h"
#include "dialog.h"
#include "mapfile.h"
extern float scaleX, scaleY;			/* display.c */

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveTellStartConv(KQMLPerformative *perf, char **contents);
static void receiveTellEndConv(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestRestart(KQMLPerformative *perf, char **contents);
static void receiveRequestRefresh(KQMLPerformative *perf, char **contents);
static void receiveRequestCreate(KQMLPerformative *perf, char **contents);

static void receiveRequestCreateCity(KQMLPerformative *perf, char **contents);
static void receiveRequestCreateTrack(KQMLPerformative *perf, char **contents);
static void receiveRequestCreateEngine(KQMLPerformative *perf, char **contents);
static Shape *createEngineShape(Object *atobj, Orientation orient,
				Color color, int outlined, Color fillcolor);
static void receiveRequestCreateTruck(KQMLPerformative *perf, char **contents);
static Shape *createTruckShape(Object *atobj, Orientation orient,
			       Color color, int outlined, Color fillcolor);
static void receiveRequestCreateRoute(KQMLPerformative *perf, char **contents);
static void receiveRequestCreateRegion(KQMLPerformative *perf, char **contents);
static Shape *parseShape(KQMLPerformative *perf, char *spec);
static Shape *parseShapeLine(KQMLPerformative *perf, char **args);
static Shape *parseShapeCircle(KQMLPerformative *perf, char **args);
static Shape *parseShapeMulti(KQMLPerformative *perf, char **args);

static void receiveRequestObj1(KQMLPerformative *perf, char **contents);
static void receiveRequestCanvas(KQMLPerformative *perf, char **contents);
static void receiveRequestHighlight(KQMLPerformative *perf, char **contents);
static void receiveRequestTranslate(KQMLPerformative *perf, char **contents);
static void receiveRequestScale(KQMLPerformative *perf, char **contents);
static void receiveRequestSetBG(KQMLPerformative *perf, char **contents);
static void receiveRequestSay(KQMLPerformative *perf, char **contents);
static void receiveRequestPostscript(KQMLPerformative *perf, char **contents);
static void receiveRequestMap(KQMLPerformative *perf, char **contents);
static void receiveRequestConfirm(KQMLPerformative *perf, char **contents);
static void receiveRequestDialog(KQMLPerformative *perf, char **contents);
static void receiveRequestSet(KQMLPerformative *perf, char **contents);
static void receiveRequestDefault(KQMLPerformative *perf, char **contents);

typedef enum {
    KEY_STR, KEY_INT, KEY_FLOAT, KEY_COLOR, KEY_BOOLEAN, KEY_LOC, KEY_OBJ,
    KEY_ORIENT, KEY_HTYPE, KEY_INTBOOL
} KeywordType;

typedef struct _KeywordValue_s {
    char *keyword;
    KeywordType type;
    void *valuep;
} KeywordValue;

static char *findKeywordValueString(char **strs, char *keyword);
static void findKeywordValues(char **strs, KeywordValue *keyvals);
static int stringToLocation(char *s, int *xp, int *yp);
static int stringToBoolean(char *str);
static int parseColor(char *str, Color *colp);
static void initRecv(void);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "tell",		"start-conversation",	receiveTellStartConv },
    { "tell",		"end-conversation",	receiveTellEndConv },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
    { "request",	"restart",		receiveRequestRestart },
    { "request",	"refresh",		receiveRequestRefresh },
    { "request",	"chdir",		NULL },
    { "request",	"create",		receiveRequestCreate },
    { "request",	"destroy",		receiveRequestObj1 },
    { "request",	"display",		receiveRequestObj1 },
    { "request",	"undisplay",		receiveRequestObj1 },
    { "request",	"canvas",		receiveRequestCanvas },
    { "request",	"highlight",		receiveRequestHighlight },
    { "request",	"unhighlight",		receiveRequestHighlight },
    { "request",	"translate",		receiveRequestTranslate },
    { "request",	"scale",		receiveRequestScale },
    { "request",	"setbg",		receiveRequestSetBG },
    { "request",	"say",			receiveRequestSay },
    { "request",	"postscript",		receiveRequestPostscript },
    { "request",	"map",			receiveRequestMap },
    { "request",	"confirm",		receiveRequestConfirm },
    { "request",	"dialog",		receiveRequestDialog },
    { "request",	"set",			receiveRequestSet },
    { "request",	"default",		receiveRequestDefault },
    { NULL,		NULL,			NULL }
};

/* Globals set during parsing then used by the above functions */
/* if you add to these, be sure to initialize them in parse(), below! */
typedef struct _Attributes_s {
    /* :CREATE */
    char *type;				/* TYPE */
    char *name;				/* NAME */
    Color color;			/* COLOR */
    int displayed;			/* DISPLAYED */
    int depth;				/* DEPTH */
    int bg;				/* BG */
    char *shapestr;			/* SHAPE */
    Shape *shape;
    /* :CREATE :CITY */
    char *label;			/* LABEL */
    int ptsize;				/* PTSIZE */
    /* :CREATE :CITY or :ENGINE or :PLANE or :TRUCK */
    Orientation orientation;		/* ORIENTATION */
    /* :CREATE :TRACK */
    Object *startobj;			/* FROM */
    Object *endobj;			/* TO */
    int distance;			/* distance */
    float time;				/* time */
    /* :CREATE :ENGINE or :PLANE or :TRUCK */
    Object *atobj;			/* AT */
    int outlined;			/* OUTLINED */
    /* :HIGHLIGHT */
    HighlightType htype;		/* HIGHLIGHT */
    int flashes;			/* FLASH */
    /* :CANVAS */
    char *title;			/* TITLE */
    int width;				/* WIDTH */
    int height;				/* WIDTH */
    /* :SHAPE */
    int thickness;			/* THICKNESS */
    int fill;				/* FILL */
    Color fillcolor;			/* FILLCOLOR */
    /* SHAPE :LINE or :ARROW */
    Point startpt;			/* START */
    Point endpt;			/* END */
    /* :SHAPE :CIRCLE */
    int radius;				/* RADIUS */
    /* :SHAPE :CIRCLE or :POLYGON */
    Point center;			/* CENTER */
    /* :SHAPE :POLYGON or :MULTILINE */
} Attributes;
static Attributes attrs, defaults;

/* TRANSLATE */
static int translateX = 0, translateY = 0;
/* SCALE */
/* Now in display.c */
/* static float scaleX = 1.0, scaleY = 1.0; */

static int redrawNeeded = 0;

/*	-	-	-	-	-	-	-	-	*/

void
receiveMsg(KQMLPerformative *perf)
{
    static int inited = 0;

    DEBUG1("verb=%s", KQML_VERB(perf));
    /* Initialize if not done already */
    if (!inited) {
	initRecv();
	inited = 1;
    }
    /* Process the message */
    trlibParsePerformative(perf, defs);
    /* Now if we have to redraw, do so */
    if (redrawNeeded) {
	displayRedraw();
	redrawNeeded = 0;
    }
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveTellStartConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayRestart();
    displayShowWindow();
    DEBUG0("done");
}

static void
receiveTellEndConv(KQMLPerformative *perf, char **contents)
{
    displayHideWindow();
    DEBUG0("done");
}

static void
receiveRequestExit(KQMLPerformative *perf, char **contents)
{
    int status = 0;

    DEBUG0("");
    if (contents[1] != NULL) {
	status = atoi(contents[1]);
    }
    programExit(status);
    DEBUG0("done");
}

static void
receiveRequestHideWindow(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayHideWindow();
    DEBUG0("done");
}

static void
receiveRequestShowWindow(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayShowWindow();
    DEBUG0("done");
}

static void
receiveRequestRestart(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayRestart();
    DEBUG0("done");
}

static void
receiveRequestRefresh(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
#ifdef undef
    if (contents[1] != NULL && STREQ(contents[1], ":force") &&
	contents[2] != NULL && STREQ(contents[2], "t")) {
	redrawNeeded = 1;
    }
#endif
    redrawNeeded = 1;
    /* The actual redraw will be done receiveMsg */
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveRequestCreate(KQMLPerformative *perf, char **contents)
{
    static KeywordValue createKeys[] = {
	{ ":type",		KEY_STR,	&attrs.type },
	{ ":name",		KEY_STR,	&attrs.name },
	{ ":color",		KEY_COLOR,	&attrs.color },
	{ ":displayed",		KEY_BOOLEAN,	&attrs.displayed },
	{ ":depth",		KEY_INT,	&attrs.depth },
	{ ":bg",		KEY_BOOLEAN,	&attrs.bg },
	{ ":fill",		KEY_INT,	&attrs.fill },
	{ ":fillcolor",		KEY_COLOR,	&attrs.fillcolor },
	{ ":thickness",		KEY_INT,	&attrs.thickness },
	{ ":shape",		KEY_STR,	&attrs.shapestr },
	{ NULL }
    };
    char *type;

    DEBUG0("");
    /* Copy defaults into current attrs */
    memcpy((char*)&attrs, (char*)&defaults, sizeof(Attributes));
    /* Extract common keyword arguments */
    findKeywordValues(contents, createKeys);
    /* Check for required arguments */
    if (attrs.type == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":type");
	return;
    }
    if (attrs.shapestr != NULL) {
	if ((attrs.shape = parseShape(perf, attrs.shapestr)) == NULL) {
	    return;
	}
    }
    /* Go create new object */
    if (STREQ(attrs.type, "city")) {
	receiveRequestCreateCity(perf, contents);
    } else if (STREQ(attrs.type, "track") ||
	       STREQ(attrs.type, "road")) {
	receiveRequestCreateTrack(perf, contents);
    } else if (STREQ(attrs.type, "engine")) {
	receiveRequestCreateEngine(perf, contents);
    } else if (STREQ(attrs.type, "truck")) {
	receiveRequestCreateTruck(perf, contents);
    } else if (STREQ(attrs.type, "route")) {
	receiveRequestCreateRoute(perf, contents);
    } else if (STREQ(attrs.type, "region")) {
	receiveRequestCreateRegion(perf, contents);
    } else {
	trlibErrorReply(perf, ERR_BAD_VALUE, attrs.type);
    }
    DEBUG0("done");
}

static void
receiveRequestCreateCity(KQMLPerformative *perf, char **contents)
{
    static KeywordValue cityKeys[] = {
	{ ":label",		KEY_STR,	&attrs.label },
	{ ":orientation",	KEY_ORIENT,	&attrs.orientation },
	{ ":ptsize",		KEY_INT,	&attrs.ptsize },
	{ NULL }
    };

    DEBUG0("");
    findKeywordValues(contents, cityKeys);
    /* Must have name and shape */
    if (attrs.name == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":name");
	return;
    }
    if (attrs.shape == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":shape");
	return;
    }
    if ((attrs.ptsize = (int)((float)attrs.ptsize * scaleX)) < 8) {
	attrs.ptsize = 8;
    }
    objectCreate(OBJ_CITY, attrs.name, attrs.displayed, attrs.depth,
		 attrs.bg, attrs.shape,
		 attrs.label, attrs.ptsize, attrs.orientation);
    DEBUG0("done");
}

static void
receiveRequestCreateTrack(KQMLPerformative *perf, char **contents)
{
    static KeywordValue trackKeys[] = {
	{ ":start",		KEY_OBJ,	&attrs.startobj },
	{ ":end",		KEY_OBJ,	&attrs.endobj },
	/* Note: these are currently ignored! */
	{ ":distance",		KEY_INT,	&attrs.distance },
	{ ":time",		KEY_FLOAT,	&attrs.time },
	{ NULL }
    };

    DEBUG0("");
    findKeywordValues(contents, trackKeys);
    /* If no name or no shape, then need start and end cities */
    if (attrs.shape == NULL || attrs.name == NULL) {
	if (attrs.startobj == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":start");
	    return;
	}
	if (attrs.endobj == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":start");
	    return;
	}
    }
    /* If no name, use start and end city names */
    if (attrs.name == NULL) {
	char *sname = attrs.startobj->any.name;
	char *ename = attrs.endobj->any.name;
	/* Leak! */
	if ((attrs.name = malloc(strlen(sname)+strlen(ename)+2)) == NULL) {
	    SYSERR0("couldn't malloc for track name");
	    return;
	}
	if (strcasecmp(sname, ename) < 0) {
	    sprintf(attrs.name, "%s-%s", sname, ename);
	} else {
	    sprintf(attrs.name, "%s-%s", ename, sname);
	}
	DEBUG1("track name = %s", attrs.name);
    }
    /* If no shape, use a line from start to end */
    if (attrs.shape == NULL) {
	int x1, y1, x2, y2;
	objectLocation(attrs.startobj, &x1, &y1);
	objectLocation(attrs.endobj, &x2, &y2);
	attrs.shape = shapeCreate(SH_LINE, attrs.color, attrs.thickness,
				  attrs.fill, attrs.fillcolor, x1, y1, x2, y2);
    }
    /* Finally, create the track itself */
    objectCreate(OBJ_TRACK, attrs.name, attrs.displayed, attrs.depth,
		 attrs.bg, attrs.startobj, attrs.endobj, attrs.shape);
    DEBUG0("done");
}

static void
receiveRequestCreateEngine(KQMLPerformative *perf, char **contents)
{
    static KeywordValue engineKeys[] = {
	{ ":at",		KEY_OBJ,	&attrs.atobj },
	{ ":orientation",	KEY_ORIENT,	&attrs.orientation },
	{ ":outlined",		KEY_BOOLEAN,	&attrs.outlined },
	{ NULL }
    };

    DEBUG0("");
    findKeywordValues(contents, engineKeys);
    /* Must have name */
    if (attrs.name == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":name");
	return;
    }
    /* If no shape, use default engine shape */
    if (attrs.shape == NULL) {
	if (attrs.atobj == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":at");
	    return;
	}
	attrs.shape = createEngineShape(attrs.atobj, attrs.orientation,
					attrs.color, attrs.outlined,
					attrs.fillcolor);
    }
    /* Finally, create the engine itself */
    objectCreate(OBJ_ENGINE, attrs.name, attrs.displayed, attrs.depth,
		 attrs.bg, attrs.atobj,attrs.orientation,attrs.outlined,
		 attrs.shape);
    DEBUG0("done");
}

static Shape *
createEngineShape(Object *atobj, Orientation orient,
		  Color color, int outlined, Color fillcolor)
{
    static Point engpts[12] = {
	{-9,5}, {0,-15}, {6,0}, {0,6}, {9,0}, {0,-3}, {3,0},
	{0,3}, {3,0}, {0,6}, {3,3}, {-24,0}
    };
    Point points[12];			/* coords for this instance */
    int engw = 24;			/* width of polygon */
    int engh = 15;			/* height of polygon */
    int wheelr = 3;			/* radius of wheel */
    int wheel1x = 7;			/* offset from center */
    int wheel2x = -5;			/* ditto (other wheel) */
    int wheely = 6;			/* ditto (both wheels) */
    int x,y,w,h,cx,cy,i,fill;
    Shape *shapes[3],*shape;

    shapeBoundingBox(atobj->any.shape,&x,&y,&w,&h);
    switch (orient) {
      case O_NONE:
      case O_NORTH: cx = x+w/2; cy = y-engh/2; break;
      case O_NORTHEAST: cx = x+w+engw/2; cy = y-engh/2; break;
      case O_EAST: cx = x+w+engw/2; cy = y+engh/2; break;
      case O_SOUTHEAST: cx = x+w+engw/2; cy = y+h+engh/2; break;
      case O_SOUTH: cx = x+w/2; cy = y+h+engh/2; break;
      case O_SOUTHWEST: cx = x-engw/2; cy = y+h+engh/2; break;
      case O_WEST: cx = x-engw/2; cy = y+engh/2; break;
      case O_NORTHWEST: cx = x-engw/2; cy = y-engh/2; break;
    }
    /* Adjust start of polygon relative to center */
    points[0].x = engpts[0].x + cx;
    points[0].y = engpts[0].y + cy;
    /* Convert relative offsets to actual locations */
    for (i=1; i < 12; i++) {
	points[i].x = points[i-1].x + engpts[i].x;
	points[i].y = points[i-1].y + engpts[i].y;
    }
    if (outlined) {
	fill = 0;
    } else {
	fill = 100;
    }
    if ((shapes[0] = shapeCreate(SH_POLYGON,color,1,fill,fillcolor,
				 cx,cy,points,12)) == NULL ||
	(shapes[1] = shapeCreate(SH_CIRCLE,color,1,fill,fillcolor,
				 cx+wheel1x,cy+wheely,wheelr)) == NULL ||
	(shapes[2] = shapeCreate(SH_CIRCLE,color,1,fill,fillcolor,
				 cx+wheel2x,cy+wheely,wheelr)) == NULL ||
	(shape = shapeCreate(SH_MULTI,color,1,fill,fillcolor,
			     shapes,3)) == NULL) {
	return NULL;
    }
    return shape;
}

/* Essentially a copy of createEngine */
static void
receiveRequestCreateTruck(KQMLPerformative *perf, char **contents)
{
    static KeywordValue truckKeys[] = {
	{ ":at",		KEY_OBJ,	&attrs.atobj },
	{ ":orientation",	KEY_ORIENT,	&attrs.orientation },
	{ ":outlined",		KEY_BOOLEAN,	&attrs.outlined },
	{ NULL }
    };

    DEBUG0("");
    findKeywordValues(contents, truckKeys);
    /* Must have name */
    if (attrs.name == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":name");
	return;
    }
    /* If no shape, use default truck shape */
    if (attrs.shape == NULL) {
	if (attrs.atobj == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":at");
	    return;
	}
	attrs.shape = createTruckShape(attrs.atobj, attrs.orientation,
					attrs.color, attrs.outlined,
					attrs.fillcolor);
    }
    /* Finally, create the truck itself */
    objectCreate(OBJ_TRUCK, attrs.name, attrs.displayed, attrs.depth,
		 attrs.bg, attrs.atobj,attrs.orientation,attrs.outlined,
		 attrs.shape);
    DEBUG0("done");
}

static Shape *
createTruckShape(Object *atobj, Orientation orient,
		  Color color, int outlined, Color fillcolor)
{
    static Point truckpts[8] = {
	{-12,-7}, {18,0}, {0,4}, {3,0}, {3,3}, {0,5}, {-24,0}, {0,-12}
    };
    Point points[8];			/* coords for this instance */
    int truckw = 24;			/* width of polygon */
    int truckh = 15;			/* height of polygon */
    int wheelr = 2;			/* radius of wheel */
    int wheelx[4] = {-10, -6, 6, 10};	/* offset from center */
    int wheely = 7;			/* ditto (all wheels) */
    int x,y,w,h,cx,cy,i,fill;
    Shape *shapes[5],*shape;

    shapeBoundingBox(atobj->any.shape,&x,&y,&w,&h);
    switch (orient) {
      case O_NONE:
      case O_NORTH: cx = x+w/2; cy = y-truckh/2; break;
      case O_NORTHEAST: cx = x+w+truckw/2; cy = y-truckh/2; break;
      case O_EAST: cx = x+w+truckw/2; cy = y+truckh/2; break;
      case O_SOUTHEAST: cx = x+w+truckw/2; cy = y+h+truckh/2; break;
      case O_SOUTH: cx = x+w/2; cy = y+h+truckh/2; break;
      case O_SOUTHWEST: cx = x-truckw/2; cy = y+h+truckh/2; break;
      case O_WEST: cx = x-truckw/2; cy = y+truckh/2; break;
      case O_NORTHWEST: cx = x-truckw/2; cy = y-truckh/2; break;
    }
    /* Adjust start of polygon relative to center */
    points[0].x = truckpts[0].x + cx;
    points[0].y = truckpts[0].y + cy;
    /* Convert relative offsets to actual locations */
    for (i=1; i < 12; i++) {
	points[i].x = points[i-1].x + truckpts[i].x;
	points[i].y = points[i-1].y + truckpts[i].y;
    }
    if (outlined) {
	fill = 0;
    } else {
	fill = 100;
    }
    if ((shapes[0] = shapeCreate(SH_POLYGON,color,1,fill,fillcolor,
				 cx,cy,points,8)) == NULL ||
	(shapes[1] = shapeCreate(SH_CIRCLE,color,1,fill,fillcolor,
				 cx+wheelx[0],cy+wheely,wheelr)) == NULL ||
	(shapes[2] = shapeCreate(SH_CIRCLE,color,1,fill,fillcolor,
				 cx+wheelx[1],cy+wheely,wheelr)) == NULL ||
	(shapes[3] = shapeCreate(SH_CIRCLE,color,1,fill,fillcolor,
				 cx+wheelx[2],cy+wheely,wheelr)) == NULL ||
	(shapes[4] = shapeCreate(SH_CIRCLE,color,1,fill,fillcolor,
				 cx+wheelx[3],cy+wheely,wheelr)) == NULL ||
	(shape = shapeCreate(SH_MULTI,color,1,fill,fillcolor,
			     shapes,5)) == NULL) {
	return NULL;
    }
    return shape;
}

static void
receiveRequestCreateRoute(KQMLPerformative *perf, char **contents)
{
    static char *trackstr;
    static KeywordValue routeKeys[] = {
	{ ":start",		KEY_OBJ,	&attrs.startobj },
	{ ":tracks",		KEY_STR,	&trackstr },
	{ NULL }
    };
    char **strs, **s;
    TrackObject **tracks;
    int ntracks;
    Shape *shape;

    DEBUG0("");
    trackstr = NULL;
    findKeywordValues(contents, routeKeys);
    /* Must have name and tracks */
    if (attrs.name == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":name");
	return;
    }
    if (trackstr == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":tracks");
	return;
    }
    /* Parse trackstr into list of track names */
    if ((strs = KQMLParseList(trackstr)) == NULL) {
	trlibErrorReply(perf, ERR_SYNTAX_ERROR, trackstr);
	return;
    }
    /* Count how many tracks */
    for (ntracks=0, s=strs; *s != NULL; ntracks++,s++) {
	/*empty*/
    }
    /* Allocate array for the tracks */
    if ((tracks = (TrackObject**)calloc(ntracks, sizeof(TrackObject*))) == NULL) {
	SYSERR0("couldn't malloc for tracks");
	gfreeall(strs);
	return;
    }
    /* Now convert each string to its Track */
    for (ntracks=0,s=strs; *s != NULL; ntracks++,s++) {
	if ((tracks[ntracks] = (TrackObject*)findObjectByName(*s)) == NULL ||
	    tracks[ntracks]->type != OBJ_TRACK) {
	    trlibErrorReply(perf, ERR_BAD_VALUE, *s);
	    gfreeall(strs);
	    free((char*)tracks);
	    return;
	}
    }
    /* And go create the thing */
    objectCreate(OBJ_ROUTE,attrs.name,attrs.displayed,attrs.depth,attrs.bg,
		 tracks, ntracks, attrs.startobj,attrs.color,attrs.thickness);
    /* Free memory */
    gfreeall(strs);
    free(tracks);
    DEBUG0("done");
}

static void
receiveRequestCreateRegion(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    /* Must have name and shape */
    if (attrs.name == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":name");
	return;
    }
    if (attrs.shape == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":shape");
	return;
    }
    /* Finally, create the region itself */
     objectCreate(OBJ_REGION,attrs.name,attrs.displayed,attrs.depth,attrs.bg,
		  attrs.shape);
    DEBUG0("done");
}

static Shape *
parseShape(KQMLPerformative *perf, char *spec)
{
    static KeywordValue shapeKeys[] = {
	{ ":thickness",	KEY_INT,	&attrs.thickness },
	{ NULL }
    };
    Shape *shape;
    char **args;

    DEBUG1("spec=%s", spec);
    /* Parse into list of strings */
    if ((args = KQMLParseList(spec)) == NULL) {
	trlibErrorReply(perf, ERR_SYNTAX_ERROR, spec);
	return NULL;
    }
    /* Empty list: humbug */
    if (args[0] == NULL) {
	trlibErrorReply(perf, ERR_BAD_VALUE, "empty list for :shape");
	gfreeall(args);
	return NULL;
    }
    /* Extract common keyword arguments */
    findKeywordValues(args, shapeKeys);
    /* First word of spec is shape type */
    if (STREQ(args[0], "line")) {
	shape = parseShapeLine(perf, args);
    } else if (STREQ(args[0], "circle")) {
	shape = parseShapeCircle(perf, args);
    } else if (STREQ(args[0], "polygon") || STREQ(args[0], "multiline")) {
	shape = parseShapeMulti(perf, args);
    } else {
	trlibErrorReply(perf, ERR_BAD_VALUE, args[0]);
	shape = NULL;
    }
    gfreeall(args);
    DEBUG0("done");
    return shape;
}

static Shape *
parseShapeLine(KQMLPerformative *perf, char **args)
{
    static KeywordValue lineKeys[] = {
	{ ":start",		KEY_LOC,	&attrs.startpt },
	{ ":end",		KEY_LOC,	&attrs.endpt },
	{ NULL }
    };

    DEBUG0("");
    findKeywordValues(args, lineKeys);
    return shapeCreate(SH_LINE, attrs.color, attrs.thickness,
		       attrs.fill, attrs.fillcolor,
		       attrs.startpt.x, attrs.startpt.y,
		       attrs.endpt.x, attrs.endpt.y);
    DEBUG0("done");
}

static Shape *
parseShapeCircle(KQMLPerformative *perf, char **args)
{
    static KeywordValue circleKeys[] = {
	{ ":center",		KEY_LOC,	&attrs.center },
	{ ":radius",		KEY_INT,	&attrs.radius },
	{ NULL }
    };

    DEBUG0("");
    findKeywordValues(args, circleKeys);
    if ((attrs.radius = (int)((float)attrs.radius * scaleX)) < 1) {
	attrs.radius = 1;
    }
    return shapeCreate(SH_CIRCLE, attrs.color, attrs.thickness,
		       attrs.fill, attrs.fillcolor,
		       attrs.center.x, attrs.center.y, attrs.radius);
    DEBUG0("done");
}

static Shape *
parseShapeMulti(KQMLPerformative *perf, char **args)
{
    static char *points, *rpoints;
    static KeywordValue multiKeys[] = {
	{ ":center",		KEY_LOC,	&attrs.center },
	{ ":points",		KEY_STR,	&points },
	{ ":rpoints",		KEY_STR,	&rpoints },
	{ NULL }
    };
    char *str, **ptlist, **p;
    int relative, npts, i, x, y;
    Point *pts;
    Shape *shape;

    DEBUG0("");
    points = rpoints = NULL;
    findKeywordValues(args, multiKeys);
    /* Must have either :points or :rpoints */
    if (points != NULL) {
	relative = 0;
	str = points;
    } else if (rpoints != NULL) {
	relative = 1;
	str = rpoints;
    } else {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, ":points or :rpoints");
	return NULL;
    }
    /* Convert to a list */
    if ((ptlist = KQMLParseList(str)) == NULL) {
	trlibErrorReply(perf, ERR_SYNTAX_ERROR, str);
	return NULL;
    }
    if (ptlist[0] == NULL) {
	trlibErrorReply(perf, ERR_BAD_VALUE, ptlist[0]);
	gfreeall(ptlist);
	return NULL;
    }
    /* Count how many points (at least one) */
    for (npts=0, p=ptlist; *p != NULL; npts++,p++) {
	/*empty*/
    }
    /* Allocate array for the points */
    if ((pts = (Point*)calloc(npts, sizeof(Point))) == NULL) {
	SYSERR0("couldn't malloc for points");
	gfreeall(ptlist);
	return NULL;
    }
    /* Now convert each item to a set of coordinates */
    for (npts=0,p=ptlist; *p != NULL; npts++,p++) {
	stringToLocation(*p, &x, &y);
	pts[npts].x = (short)x;
	pts[npts].y = (short)y;
    }
    /* In `relative' mode, adjust coords to absolute ones */
    if (relative) {
	for (i=1; i < npts; i++) {
	    pts[i].x += pts[i-1].x;
	    pts[i].y += pts[i-1].y;
	}
    }
    /* Finally, go create the shape */
    if (STREQ(args[0], "polygon")) {
	shape = shapeCreate(SH_POLYGON, attrs.color, attrs.thickness,
			    attrs.fill, attrs.fillcolor,
			    attrs.center.x, attrs.center.y,
			    pts, npts);
    } else {
	shape = shapeCreate(SH_MULTILINE, attrs.color, attrs.thickness,
			    attrs.fill, attrs.fillcolor,
			    pts, npts);
    }
    /* Free points */
    gfreeall(ptlist);
    free(pts);
    /* Return shape */
    return shape;
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveRequestObj1(KQMLPerformative *perf, char **contents)
{
    Object *obj;

    DEBUG1("%s", contents[0]);
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "object name");
	return;
    }
    if ((obj = findObjectByName(contents[1])) == NULL) {
	trlibErrorReply(perf, ERR_BAD_VALUE, contents[1]);
	return;
    }
    if (STREQ(contents[0], "destroy")) {
	objectDestroy(obj);
    } else if (STREQ(contents[0], "display")) {
	obj->any.displayed = 1;
    } else if (STREQ(contents[0], "undisplay")) {
	obj->any.displayed = 0;
    }
    redrawNeeded = 1;
    DEBUG0("done");
}

static void
receiveRequestCanvas(KQMLPerformative *perf, char **contents)
{
    static KeywordValue canvasKeys[] = {
	{ ":title",		KEY_STR,	&attrs.title },
	{ ":width",		KEY_INT,	&attrs.width },
	{ ":height",		KEY_INT,	&attrs.height },
	{ NULL }
    };

    DEBUG0("");
    /* Extract keyword arguments */
    findKeywordValues(contents, canvasKeys);
    /* Set canvas */
    attrs.width = (int)((float)attrs.width * scaleX);
    attrs.height = (int)((float)attrs.height * scaleY);
    displaySetCanvas(attrs.title, attrs.width, attrs.height, NULL);
    DEBUG0("done");
}

static void
receiveRequestHighlight(KQMLPerformative *perf, char **contents)
{
    static KeywordValue highlightKeys[] = {
	{ ":color",		KEY_COLOR,	&attrs.color },
	{ ":type",		KEY_HTYPE,	&attrs.htype },
	{ ":flash",		KEY_INTBOOL,	&attrs.flashes },
	{ NULL }
    };
    Object *obj;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "object name");
	return;
    }
    if ((obj = findObjectByName(contents[1])) == NULL) {
	trlibErrorReply(perf, ERR_BAD_VALUE, contents[1]);
	return;
    }
    if (STREQ(contents[0], "highlight")) {
	stringToColor("red", &attrs.color);
	attrs.htype = HI_OBJECT;
	attrs.flashes = 0;
	findKeywordValues(contents, highlightKeys);
	objectHighlight(obj, attrs.htype, attrs.color, attrs.flashes);
    } else if (STREQ(contents[0], "unhighlight")) {
	/* Unhighlight has this strange way of indicating "don't care" */
	Color *colorp = NULL;
	int *flashesp = NULL;
	attrs.htype = HI_NONE;
	findKeywordValues(contents, highlightKeys);
	if (findKeywordValueString(contents, ":color") != NULL) {
	    colorp = &(attrs.color);
	}
	if (findKeywordValueString(contents, ":flash") != NULL) {
	    flashesp = &(attrs.flashes);
	}
	objectUnhighlight(obj, attrs.htype, colorp, flashesp);
    }
    /* Too much flashing! Don't redraw now. Hope that's ok.
    redrawNeeded = 1;
    */
    DEBUG0("done");
}

static void
receiveRequestTranslate(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    if (contents[1] == NULL || contents[2] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "coordinates");
	return;
    }
    translateX = atoi(contents[1]);
    translateY = atoi(contents[2]);
    DEBUG2("translate: x=%d, y=%d", translateX, translateY);
    DEBUG0("done");
}

static void
receiveRequestScale(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    if (contents[1] == NULL || contents[2] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "coordinates");
	return;
    }
    scaleX = (float)atof(contents[1]);
    scaleY = (float)atof(contents[2]);
    DEBUG2("scale: x=%f, y=%f", scaleX, scaleY);
    DEBUG0("done");
}

static void
receiveRequestSetBG(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displaySetBackground();
    DEBUG0("done");
}

static void
receiveRequestSay(KQMLPerformative *perf, char **contents)
{
    char *s;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "string to say");
	return;
    }
    s = KQMLParseThing(contents[1]);
    displaySay(s);
    free(s);
    DEBUG0("done");
}

static void
receiveRequestPostscript(KQMLPerformative *perf, char **contents)
{
    char *s;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "filename");
	return;
    }
    s = KQMLParseThing(contents[1]);
    psOutput(s);
    free(s);
    DEBUG0("done");
}

static void
receiveRequestMap(KQMLPerformative *perf, char **contents)
{
    char *s;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "mapname");
	return;
    }
    s = KQMLParseThing(contents[1]);
    readMapFile(s);
    free(s);
    redrawNeeded = 1;
    DEBUG0("done");
}

static void
receiveRequestConfirm(KQMLPerformative *perf, char **contents)
{
    char *prompt, *tag;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "tag");
	return;
    }
    if (contents[2] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "prompt");
	return;
    }
    tag = KQMLParseThing(contents[1]);
    prompt = KQMLParseThing(contents[2]);
    popupConfirmer(prompt, tag);
    free(prompt);
    free(tag);
    DEBUG0("done");
}

static void
receiveRequestDialog(KQMLPerformative *perf, char **contents)
{
    char *s;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "dialog type");
	return;
    }
    if (STREQ(contents[1], ":goals")) {
	if (contents[2] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[1]);
	    return;
	}
	s = KQMLParseThing(contents[2]);
	displayDialog(DIALOG_GOALS, s);
	gfree(s);
    } else {
	trlibErrorReply(perf, ERR_BAD_VALUE, contents[1]);
	return;
    }
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveRequestSet(KQMLPerformative *perf, char **contents)
{
    Object *obj;

    DEBUG0("");
    /* Find object to set */
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "object name");
	return;
    }
    if ((obj = findObjectByName(contents[1])) == NULL) {
	trlibErrorReply(perf, ERR_BAD_VALUE, contents[1]);
	return;
    }
    DEBUG1("obj = %s", contents[1]);
    contents += 2;
    /* Process the remaining args as key/val pairs */
    while (contents[0]) {
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	DEBUG2("set: %s = %s", contents[0], contents[1]);
	if (STREQ(contents[0], ":displayed")) {
	    obj->any.displayed = stringToBoolean(contents[1]);
	} else if (STREQ(contents[0], ":color")) {
	    Color col;
	    if (parseColor(contents[1], &col) == 0) {
		shapeSetColor(obj->any.shape, col);
	    }
	} else if (STREQ(contents[0], ":depth")) {
	    obj->any.depth = atoi(contents[1]);
	} else if (STREQ(contents[0], ":bg")) {
	    obj->any.bg = stringToBoolean(contents[1]);
	} else if (STREQ(contents[0], ":thickness")) {
	    shapeSetThickness(obj->any.shape, atoi(contents[1]));
	} else if (STREQ(contents[0], ":fill")) {
	    shapeSetFill(obj->any.shape, atoi(contents[1]));
	} else if (STREQ(contents[0], ":fillcolor")) {
	    Color col;
	    if (parseColor(contents[1], &col) == 0) {
		shapeSetFillColor(obj->any.shape, col);
	    }
	} else {
	    switch (obj->type) {
	      case OBJ_CITY:
	      case OBJ_TRACK:
	      case OBJ_ROUTE:
		ERROR1("can't use SET on non-ENGINE %s", obj->any.name);
		break;
	      case OBJ_ENGINE:
		if (STREQ(contents[0], ":outlined")) {
		    obj->engine.outlined = stringToBoolean(contents[1]);
		} else if (STREQ(contents[0], ":at")) {
		    obj->engine.atcity =
			(CityObject*)findObjectByName(contents[1]);
		} else if (STREQ(contents[0], ":orientation")) {
		    obj->engine.orient = stringToOrientation(contents[1]);
		} else {
		    ERROR1("bad attr for ENGINE %s", obj->any.name);
		}
		obj->any.shape =
		    createEngineShape((Object*)(obj->engine.atcity),
				      obj->engine.orient, obj->any.color,
				      obj->engine.outlined,
				      obj->any.shape->any.fillcolor);
	    }
	}
	/* Next key/val pair */
	contents += 2;
    }
    DEBUG0("done");
}

static void
receiveRequestDefault(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    /* First word of contents was `default' */
    contents += 1;
    /* Process the remaining args as key/val pairs */
    while (contents[0]) {
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	DEBUG2("default: %s = %s", contents[0], contents[1]);
	if (STREQ(contents[0], ":displayed")) {
	    defaults.displayed = stringToBoolean(contents[1]);
	} else if (STREQ(contents[0], ":color")) {
	    Color col;
	    if (parseColor(contents[1], &col) == 0) {
		defaults.color = col;
	    }
	} else if (STREQ(contents[0], ":depth")) {
	    defaults.depth = atoi(contents[1]);
	} else if (STREQ(contents[0], ":bg")) {
	    defaults.bg = stringToBoolean(contents[1]);
	} else if (STREQ(contents[0], ":thickness")) {
	    defaults.thickness = atoi(contents[1]);
	} else if (STREQ(contents[0], ":radius")) {
	    defaults.radius = atoi(contents[1]);
	} else if (STREQ(contents[0], ":fill")) {
	    defaults.fill = atoi(contents[1]);
	} else if (STREQ(contents[0], ":fillcolor")) {
	    Color col;
	    if (parseColor(contents[1], &col) == 0) {
		defaults.fillcolor = col;
	    }
	} else if (STREQ(contents[0], ":start")) {
	    defaults.startobj = findObjectByName(contents[1]);
	} else if (STREQ(contents[0], ":end")) {
	    defaults.endobj = findObjectByName(contents[1]);
	} else if (STREQ(contents[0], ":outlined")) {
	    defaults.outlined = stringToBoolean(contents[1]);
	} else if (STREQ(contents[0], ":at")) {
	    defaults.atobj = findObjectByName(contents[1]);
	} else if (STREQ(contents[0], ":orientation")) {
	    defaults.orientation = stringToOrientation(contents[1]);
	}
	/* Next key/val pair */
	contents += 2;
    }
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Returns value for keyword in list of keyword/value pairs, or NULL.
 * Does not allocate space for string.
 */
static char *
findKeywordValueString(char **strs, char *keyword)
{
    while (*strs != NULL) {
	if (STREQ(*strs, keyword)) {
	    /* Note: can be NULL if value is missing */
	    return *(strs+1);
	}
	strs += 1;
    }
    return NULL;
}

static void
findKeywordValues(char **strs, KeywordValue *keyvals)
{
    char *s;
    Color col;
    int x, y;
    Object *obj;
    Orientation ort;

    while (keyvals && keyvals->keyword) {
	if (keyvals->valuep != NULL) {
	    if ((s=findKeywordValueString(strs, keyvals->keyword)) != NULL) {
		/* Set new value */
		switch (keyvals->type) {
		  case KEY_STR:
		    /* Memory leak! */
		    *(char**)(keyvals->valuep) = KQMLParseThing(s);
		    break;
		  case KEY_INT:
		    *(int*)(keyvals->valuep) = atoi(s);
		    break;
		  case KEY_FLOAT:
		    *(float*)(keyvals->valuep) = atof(s);
		    break;
		  case KEY_COLOR:
		    if (parseColor(s, &col) < 0) {
			ERROR1("couldn't convert string to color: %s", s);
		    } else {
			*(Color*)(keyvals->valuep) = col;
		    }
		    break;
		  case KEY_BOOLEAN:
		    *(int*)(keyvals->valuep) = stringToBoolean(s);
		    break;
		  case KEY_LOC:
		    stringToLocation(s, &x, &y);
		    ((Point*)(keyvals->valuep))->x = (short)x;
		    ((Point*)(keyvals->valuep))->y = (short)y;
		    break;
		  case KEY_OBJ:
		    if ((obj = findObjectByName(s)) == NULL) {
			ERROR1("couldn't find object: %s", s);
		    } else {
			*(Object**)(keyvals->valuep) = obj;
		    }
		    break;
		  case KEY_ORIENT:
		    if (STREQ(s, "north")) {
			ort = O_NORTH;
		    } else if (STREQ(s, "northeast")) {
			ort = O_NORTHEAST;
		    } else if (STREQ(s, "east")) {
			ort = O_EAST;
		    } else if (STREQ(s, "southeast")) {
			ort = O_SOUTHEAST;
		    } else if (STREQ(s, "south")) {
			ort = O_SOUTH;
		    } else if (STREQ(s, "southwest")) {
			ort = O_SOUTHWEST;
		    } else if (STREQ(s, "west")) {
			ort = O_WEST;
		    } else if (STREQ(s, "northwest")) {
			ort = O_NORTHWEST;
		    }
		    *(Orientation*)(keyvals->valuep) = ort;
		    break;
		  case KEY_HTYPE:
		    *(HighlightType*)(keyvals->valuep) =
			stringToHighlightType(s);
		    break;
		  case KEY_INTBOOL:
		    if (isdigit(*s)) {
			*(int*)(keyvals->valuep) = atoi(s);
		    } else if (STREQ(s, "t") || STREQ(s, "true")) {
			*(int*)(keyvals->valuep) = -1;
		    } else if (STREQ(s, "nil") || STREQ(s, "false")) {
			*(int*)(keyvals->valuep) = 0;
		    } else {
			ERROR1("couldn't convert string to boolean: %s", s);
		    }
		    break;
		}
	    }
	}
	keyvals += 1;
    }
}

/* Location is either an object or a pair of coords */
static int
stringToLocation(char *s, int *xp, int *yp)
{
    Object *obj;
    char **coords = NULL;
    int ret = 0;

    if (*s != '(') {
	/* Token: must be object */
	if ((obj = findObjectByName(s)) == NULL) {
	    ERROR1("couldn't find object: %s", s);
	    ret = -1;
	} else {
	    objectLocation(obj, xp, yp);
	}
    } else if ((coords = KQMLParseList(s)) == NULL ||
	       coords[0] == NULL || coords[1] == NULL) {
	/* Bogus list */
	ERROR1("couldn't convert to coords: %s", s);
	ret = -1;
    } else {
	/* List: (X Y) */
	*xp = (int)((float)(atoi(coords[0]) + translateX) * scaleX);
	*yp = (int)((float)(atoi(coords[1]) + translateY) * scaleY);
    }
    gfreeall(coords);
    return ret;
}

static int
stringToBoolean(char *str)
{
    if (STREQ(str, "nil") || STREQ(str, "false")) {
	return 0;
    } else {
	return 1;
    }
}

static int
parseColor(char *str, Color *colp)
{
    char *s;
    int ret;

    s = KQMLParseThing(str);
    ret = stringToColor(s, colp);
    gfree(s);
    return ret;
}

/*	-	-	-	-	-	-	-	-	*/

static void
initRecv(void)
{
    defaults.name = NULL;
    stringToColor("black", &(defaults.color));
    defaults.displayed = 1;
    defaults.shape = NULL;
    defaults.depth = 0;
    defaults.bg = 0;
    defaults.label = NULL;
    defaults.ptsize = 14;
    defaults.orientation = O_NONE;
    defaults.startobj = NULL;
    defaults.endobj = NULL;
    defaults.atobj = NULL;
    defaults.outlined = 0;
    defaults.htype = HI_NONE;
    defaults.flashes = 0;
    defaults.title = NULL;
    defaults.width = 0;
    defaults.height = 0;
    defaults.thickness = 1;
    defaults.fill = 0;
    stringToColor("black", &(defaults.fillcolor));
    defaults.radius = 0;
}
