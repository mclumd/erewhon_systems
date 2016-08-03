/*
 * display.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 26 Feb 1996
 * Time-stamp: <Thu Nov 14 17:54:23 EST 1996 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/param.h>
#include <Xm/Xm.h>
#include <Xm/MainW.h>
#include <Xm/RowColumn.h>
#include <Xm/CascadeB.h>
#include <Xm/PushB.h>
#include <Xm/DrawingA.h>
#include <X11/xpm.h>
#include "util/error.h"
#include "util/debug.h"
#include "display.h"
#include "select.h"

#ifdef SOLARIS
# define sincos(T,SP,CP)	*SP = sin(T); *CP = cos(T)
#endif

typedef enum {
    GC_BLACK = 0, GC_RED = 1, GC_YELLOW = 2, GC_GREEN = 3, GC_BACKGROUND = 4,
    GC_NUM = 5
} GCSelector;

/*
 * Functions defined here:
 */
void displayInit(int argc, char **argv);
void displayProcessEvents(void);
void displayHideWindow(void);
void displayShowWindow(void);
static void displayInitGraphics(int argc, char **argv);
static void displayInitWidgets(void);
static void displayInitControlMenu(Widget menubar);
static void displayInitGCs(void);
static void exposeCB(Widget w, XtPointer client_data, XtPointer call_data);
static void inputCB(Widget w, XtPointer client_data, XtPointer call_data);
static void endConvCB(Widget w, XtPointer client_data, XtPointer call_data);
static void exitCB(Widget w, XtPointer client_data, XtPointer call_data);
void displayDoLayout(void);
static void displayLayoutChildren(Client *c, double theta);
static void displayLayoutClient(Client *c, int centerx, int centery,
				  int rad, double theta);
void displayRedraw(void);
void displayStatus(Client *c);
static void displayDrawClient(Client *c);
static void displayDrawCircle(int x, int y, int r,
				GCSelector whichgc, char *name, int fill);
static void displayStatusBriefly(void);
void displayMessageRecv(Client *from, KQMLPerformative *perf);
void displayMessageSend(Client *to, KQMLPerformative *perf);
static void displayDrawRecv(Client *from, KQMLPerformative *perf);
static void displayDrawSend(Client *to, KQMLPerformative *perf);
static void recvTimerCB(XtPointer client_data, XtIntervalId *timer);
static void sendTimerCB(XtPointer client_data, XtIntervalId *timer);
static GCSelector perfToGC(KQMLPerformative *perf);
static Pixmap readPixmap(char *filename);

/*
 * Data defined here:
 */
static XtAppContext appcon;
static Widget toplevel;
static Display *display;
static Screen *screen;
static Colormap colormap;
static Widget canvasW;
static Window canvas;
static GC gc[GC_NUM];
static int timeoutCount = 0;
static Boolean reallyDisplaying = True;

typedef struct _AppResources_s {
    XFontStruct *font;
    Boolean drawSubClients;
    String logo;
    Boolean showlogo;
} AppResources;
static AppResources appres;

static XtResource resources[] = {
    { "font", "Font", XtRFontStruct, sizeof(XFontStruct),
      XtOffsetOf(AppResources,font), XtRString, "-*-helvetica-*-r-*-*-8-0-*-*-*-*-*-*" },
    { "drawSubClients", "DrawSubClients", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources, drawSubClients), XtRString, "true" },
    { "logo", "Logo", XtRString, sizeof(String),
      XtOffsetOf(AppResources, logo), XtRImmediate, "im_logo.xpm" },
    { "showlogo", "Showlogo", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources, showlogo), XtRString, "False" },
};
static XrmOptionDescRec options[] = {
    { "-showlogo",	".showlogo",	XrmoptionSepArg },
};

static String fallbackResources[] = {
    "*title:			TRAINS Input Manager",
    "*geometry:			-0+0",
    "*background:		grey75",
    "*canvas.width:		256",
    "*canvas.height:		256",
    NULL
};

/*	-	-	-	-	-	-	-	-	*/

void
displayInit(int argc, char **argv)
{
    XSetWindowAttributes attrs;

    DEBUG0("initializing display");
    displayInitGraphics(argc, argv);
    displayInitWidgets();
    XtRealizeWidget(toplevel);
    /* We need the window of the simple widget for drawing into */
    canvas = XtWindow(canvasW);
    /* Maybe the server can help us redraw the window... */
    attrs.backing_store = 1;
    XChangeWindowAttributes(display, canvas, CWBackingStore, &attrs);
    /* Now we can create the GCs */
    displayInitGCs();
    /* Register the fd of the X connection so we will select() it */
    registerFd(XConnectionNumber(XtDisplay(toplevel)), IM_DISPLAY);
    /* Flush out the drawing (we hope) */
    XSync(XtDisplay(toplevel), False);
    displayProcessEvents();
    if (appres.showlogo) {
	inputCB(NULL, NULL, NULL);
    }
    DEBUG0("done");
}

void
displayProcessEvents(void)
{
    XtInputMask ret;

    DEBUG0("checking for events");
    while ((ret=XtAppPending(appcon)) != (XtInputMask)0) {
	DEBUG0("processing next event");
	XtAppProcessEvent(appcon, ret);
    }
    DEBUG0("done");
}

void
displayHideWindow(void)
{
    XtVaSetValues(toplevel, XtNiconic, True, NULL);
}

void
displayShowWindow(void)
{
    XtVaSetValues(toplevel, XtNiconic, False, NULL);
}

/*	-	-	-	-	-	-	-	-	*/

static void
displayInitGraphics(int argc, char **argv)
{
    toplevel = XtVaAppInitialize(&appcon, "TRAINS",
				 options, XtNumber(options),
				 &argc, argv, fallbackResources,
				 NULL);
    display = XtDisplay(toplevel);
    screen = XtScreen(toplevel);
    colormap = DefaultColormapOfScreen(screen);
    XtGetApplicationResources(toplevel, (XtPointer)&appres,
			      resources, XtNumber(resources), NULL, 0);
}

static void
displayInitWidgets(void)
{
    Widget mainW, menubarW;
    Arg args[5];
    int n;

    /* Main window */
    n = 0;
    XtSetArg(args[n], XmNshowSeparator, True); n++;
    mainW = XmCreateMainWindow(toplevel, "main", args, n);
    XtManageChild(mainW);
    /* Menubar */
    n = 0;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    XtSetArg(args[n], XmNmarginWidth, 0); n++;
    menubarW = XmCreateMenuBar(mainW, "menubar", args, n);
    XtManageChild(menubarW);
    /* Control Menu */
    displayInitControlMenu(menubarW);
    /* Drawing Area (canvas) */
    n = 0;
    canvasW = XmCreateDrawingArea(mainW, "canvas", args, n);
    XtManageChild(canvasW);
    XtAddCallback(canvasW, XmNexposeCallback, exposeCB, NULL);
    XtAddCallback(canvasW, XmNinputCallback, inputCB, NULL);
    /* Set children of main window */
    XmMainWindowSetAreas(mainW, menubarW, NULL, NULL, NULL, canvasW);
}

static void
displayInitControlMenu(Widget menubar)
{
    Widget menu, button;
    unsigned char *labstr;
    Arg args[3];
    int n;

    n = 0;
    menu = XmCreatePulldownMenu(menubar, "control", args, n);
    /* End conversation */
    n = 0;
    labstr = XmStringCreate("End Conversation", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    button = XmCreatePushButton(menu, "endconv", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, endConvCB, NULL);
    XmStringFree(labstr);
    /* IM Exit */
    n = 0;
    labstr = XmStringCreate("IM Exit", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    button = XmCreatePushButton(menu, "exit", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, exitCB, NULL);
    XmStringFree(labstr);
    /* Add to menubar */
    labstr = XmStringCreate("Control", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNsubMenuId, menu); n++;
    button = XmCreateCascadeButton(menubar, "control", args, n);
    XtManageChild(button);
    XmStringFree(labstr);
}

static void
displayInitGCs(void)
{
    XGCValues values;
    unsigned long mask;
    XColor color, exact;
    unsigned long bg;

    values.function = GXcopy;
    values.fill_style = FillSolid;
    mask = GCFunction | GCFillStyle | GCForeground;
    /* Red */
    if (!XAllocNamedColor(display, colormap, "red", &color, &exact)) {
	ERROR0("couldn't allocate color red");
	gc[GC_RED] = XDefaultGCOfScreen(screen);
    } else {
	values.foreground = color.pixel;
	gc[GC_RED] = XCreateGC(display, canvas, mask, &values);
    }
    /* Yellow */
    if (!XAllocNamedColor(display, colormap, "yellow", &color, &exact)) {
	ERROR0("couldn't allocate color yellow");
	gc[GC_YELLOW] = XDefaultGCOfScreen(screen);
    } else {
	values.foreground = color.pixel;
	gc[GC_YELLOW] = XCreateGC(display, canvas, mask, &values);
    }
    /* Green */
    if (!XAllocNamedColor(display, colormap, "green", &color, &exact)) {
	ERROR0("couldn't allocate color green");
	gc[GC_GREEN] = XDefaultGCOfScreen(screen);
    } else {
	values.foreground = color.pixel;
	gc[GC_GREEN] = XCreateGC(display, canvas, mask, &values);
    }
    /* Black (with font for module labels) */
    values.font = appres.font->fid;
    mask |= GCFont;
    if (!XAllocNamedColor(display, colormap, "black", &color, &exact)) {
	ERROR0("couldn't allocate color black");
	gc[GC_BLACK] = XDefaultGCOfScreen(screen);
    } else {
	values.foreground = color.pixel;
	gc[GC_BLACK] = XCreateGC(display, canvas, mask, &values);
    }
    /* Erase to BG */
    values.function = GXcopy;
    values.fill_style = FillSolid;
    mask = GCFunction | GCFillStyle | GCForeground;
    XtVaGetValues(toplevel, XtNbackground, &bg, NULL);
    values.foreground = bg;
    gc[GC_BACKGROUND] = XCreateGC(display, canvas, mask, &values);
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Callbacks
 */
static void
exposeCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    DEBUG0("EXPOSE!");
    displayRedraw();
    DEBUG0("done");
}

static void
inputCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    static Pixmap logoPixmap = None;
    XmDrawingAreaCallbackStruct *info =
	(XmDrawingAreaCallbackStruct*)call_data;

    DEBUG0("toggle!");
    if (info && info->event && info->event->xany.type != ButtonRelease) {
	DEBUG0("ignoring event");
	return;
    }
    reallyDisplaying = !reallyDisplaying;
    if (reallyDisplaying) {
	/* We are turning on the display */
	XtVaSetValues(canvasW, XmNbackgroundPixmap, XmUNSPECIFIED_PIXMAP,
		      NULL);
    } else {
	/* We are turning off the display (ie., showing the logo) */
	if (logoPixmap == None) {
            logoPixmap = readPixmap(appres.logo);
	}
	XtVaSetValues(canvasW, XmNbackgroundPixmap, logoPixmap, NULL);
	XClearWindow(display, canvas);
    }
    /* Update either the big display or the brief status indicator */
    displayDoLayout();
    DEBUG0("done");
}

static void
endConvCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    static KQMLPerformative *perf;

    DEBUG0("end-conversation");
    if (perf == NULL) {
	if ((perf = KQMLNewPerformative("tell")) == NULL) {
	    return;
	}
	KQMLSetParameter(perf, ":content", "(end-conversation)");
    }
    broadcastPerformative(NULL, perf);
    DEBUG0("done");
}

static void
exitCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    DEBUG0("exiting");
    exit(0);
}

/*	-	-	-	-	-	-	-	-	*/

#define FLASH_MSEC 500
static int imx;
static int imy;
static int imr = 12;
static int centerr = 64;
static int clientr = 12;
static int arrowlen = 8;
static int arrowangle = 10;

void
displayDoLayout(void)
{
    Client *c;
    double theta;
    Dimension width, height;
    int n, x, y;

    if (!reallyDisplaying) {
	DEBUG0("doing brief status display");
	displayStatusBriefly();
	DEBUG0("done");
	return;
    }
    DEBUG0("counting clients");
    /* Count how many connected clients there are */
    n = 0;
    for (c=clientList; c != NULL; c=c->next) {
	/* Only count clients that are the "main" client for their fd */
	if (c->fd != -1 && c == findClientByFd(c->fd)) {
	    DEBUG1("main client: %s", c->name);
	    n += 1;
	}
    }
    /* Get size of drawing window */
    XtVaGetValues(canvasW, XmNwidth, &width, XmNheight, &height, NULL);
    DEBUG2("width=%ld, height=%ld", width, height);
    imx = width / 3;
    imy = height / 2;
    DEBUG1("%d main clients to layout", n);
    if (n > 0) {
	/* Adjust the positions of the clients */
	theta = 0;
	for (c=clientList; c != NULL; c=c->next) {
	    /* Spokes from IM are for "main" clients only */
	    if (c->fd != -1 && c == findClientByFd(c->fd)) {
		DEBUG2("main client: %s, theta=%lf", c->name, theta);
		c->r = clientr;
		displayLayoutClient(c, imx, imy, centerr, theta);
		/* Layout any "children" of this main client */
		if (appres.drawSubClients) {
		    displayLayoutChildren(c, theta);
		}
		/* Next client (spoke) */
		theta += 360.0 / (double)n;
	    }
	}
    }
    /* Layout any dead clients on the right side */
    x = 3*width / 4;
    y = 2*clientr;
    for (c=clientList; c != NULL; c=c->next) {
	if (c->fd == -1) {
	    DEBUG1("dead client: %s", c->name);
	    c->x = x;
	    c->y = y;
	    c->r = clientr - 4;
	    y += clientr * 2;
	}
    }
    /* And redraw everything */
    displayRedraw();
    DEBUG0("done");
}

/*
 * Children are layed out around their parent on the side opposite the
 * spoke to the IM.
 */
static void
displayLayoutChildren(Client *c, double theta)
{
    Client *c2;
    int n, theta2, delta, sign, d;

    DEBUG1("laying out children for %s", c->name);
    /* First count number of children */
    n = 0;
    for (c2=clientList; c2 != NULL; c2=c2->next) {
	if (c2->fd != -1 && c2 != c && c2->fd == c->fd) {
	    n += 1;
	}
    }
    /* None, c'est tout */
    DEBUG1("%d children to layout", n);
    if (n == 0) {
	return;
    }
    /* Otherwise, use 20 degrees or 180/n, whichever is smaller as the angle
     * between clients.
     */
    if (180/n > 20) {
	delta = 20;
    } else {
	delta = 180/n;
    }
    theta2 = 0;
    /* What direction from "center" (ie., opposite spoke) */
    sign = 0;
    /* Distance to child varies also */
    d = 0;
    /* Now layout the children */
    for (c2=clientList; c2 != NULL; c2=c2->next) {
	if (c2->fd != -1 && c2 != c && c2->fd == c->fd) {
	    DEBUG3("child client: %s, sign=%d, theta2=%d",
		   c2->name, sign, theta2);
	    c2->r = clientr - 4;
	    displayLayoutClient(c2, c->x, c->y, centerr+d,theta+sign*theta2);
	    /* Switch angle to other side */
	    if (sign == 0) {
		sign = 1;
		theta2 = delta;
		d = clientr;
	    } else if (sign == 1) {
		sign = -1;
	    } else {
		sign = 1;
		theta2 += delta;
		d = -d;
	    }
	}
    }
    DEBUG0("done");
}
	
static void
displayLayoutClient(Client *c, int centerx, int centery,
		      int rad, double theta)
{
    double sintheta, costheta;

    DEBUG3("%s: rad=%d, theta=%lf", c->name, rad, theta);
    /* Compute positions relative to given center */
    sincos(theta/180*M_PI, &sintheta, &costheta);
    /* x,y is the center of this client's circle */
    c->x = centerx + rad * costheta;
    c->y = centery + rad * sintheta;
    DEBUG2("x=%d, y=%d", c->x, c->y);
    /* linePts = line from IM circle to client circle */
    c->linePts[0].x = centerx + imr * costheta;
    c->linePts[0].y = centery + imr * sintheta;
    c->linePts[1].x = centerx + (rad - c->r - 1) * costheta;
    c->linePts[1].y = centery + (rad - c->r - 1) * sintheta;
    /* recvPts is an arrow from client to IM (ccw from spoke) */
    sincos((180+(theta-arrowangle))/180*M_PI, &sintheta, &costheta);
    c->recvPts[0].x = c->x + (c->r+1) * costheta;
    c->recvPts[0].y = c->y + (c->r+1) * sintheta;
    sincos((theta+arrowangle)/180*M_PI, &sintheta, &costheta);
    c->recvPts[1].x = centerx + (imr+1) * costheta;
    c->recvPts[1].y = centery + (imr+1) * sintheta;
    c->recvPts[2].x = centerx + (imr+arrowlen) * costheta;
    c->recvPts[2].y = centery + (imr+arrowlen) * sintheta;
    /* sendPts is an arrow from IM to client (cw from spoke) */
    sincos((theta-arrowangle)/180*M_PI, &sintheta, &costheta);
    c->sendPts[0].x = centerx + (imr+1) * costheta;
    c->sendPts[0].y = centery + (imr+1) * sintheta;
    sincos((180+(theta+arrowangle))/180*M_PI, &sintheta, &costheta);
    c->sendPts[1].x = c->x + (c->r+1) * costheta;
    c->sendPts[1].y = c->y + (c->r+1) * sintheta;
    c->sendPts[2].x = c->x + (c->r+arrowlen) * costheta;
    c->sendPts[2].y = c->y + (c->r+arrowlen) * sintheta;
    DEBUG0("done");
}

void
displayRedraw(void)
{
    Client *c;

    if (!reallyDisplaying) {
	DEBUG0("not displaying!");
	return;
    }
    DEBUG0("clearing window");
    XClearWindow(display, canvas);
    displayDrawCircle(imx, imy, imr, GC_BLACK, "IM", 0);
    for (c=clientList; c != NULL; c=c->next) {
	displayDrawClient(c);
    }
    DEBUG0("syncing display");
    XSync(XtDisplay(toplevel), False);
    displayProcessEvents();
    DEBUG0("done");
}

void
displayStatus(Client *c)
{
#ifdef undef
    /* Used to be we could just change our color, but now we have to redraw */
    displayDrawClient(c);
    XSync(XtDisplay(toplevel), False);
#endif
    displayDoLayout();
}

static void
displayDrawClient(Client *c)
{
    GCSelector whichgc;

    switch (c->state) {
      case IM_CONNECTED: whichgc = GC_YELLOW; break;
      case IM_READY: whichgc = GC_GREEN; break;
      default: whichgc = GC_RED;
    }
    displayDrawCircle(c->x, c->y, c->r, whichgc, c->name, 1);
    if (c->fd != -1) {
	XDrawLines(display, canvas, gc[GC_BLACK],
		   (XPoint*)(c->linePts), 2, CoordModeOrigin);
    }
}

static void
displayDrawCircle(int x, int y, int r, GCSelector whichgc, char *name,
		    int fill)
{
    int dir, ascent, descent;
    XCharStruct overall;

    DEBUG3("name=%s at %d,%d", name ? name : "<null>", x, y);
    if (fill) {
	XFillArc(display, canvas, gc[whichgc], x-r, y-r,
		 (unsigned int)r*2, (unsigned int)r*2, 0, 360*64);
    } else {
	XDrawArc(display, canvas, gc[whichgc], x-r, y-r,
		 (unsigned int)r*2, (unsigned int)r*2, 0, 360*64);
    }
    if (name) {
	XTextExtents(appres.font, name, strlen(name),
		     &dir, &ascent, &descent, &overall);
	x -= overall.width / 2;
	y += (ascent + descent) / 2;
	XDrawString(display, canvas, gc[GC_BLACK], x, y, name, strlen(name));
    }
    DEBUG0("done");
}

static void
displayStatusBriefly(void)
{
    Client *c;
    GCSelector whichgc = GC_GREEN;

    DEBUG0("doing brief status display");
    for (c=clientList; c != NULL; c=c->next) {
	switch (c->state) {
	  case IM_READY:
	      break;
	  case IM_CONNECTED:
	      if (whichgc == GC_GREEN) {
		  whichgc = GC_YELLOW;
	      }
	      break;
	  default:
	      whichgc = GC_RED;
	}
    }
    DEBUG1("status is %d", whichgc);
    displayDrawCircle(240, 16, 5, whichgc, NULL, 1);
    displayProcessEvents();
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

void
displayMessageRecv(Client *from, KQMLPerformative *perf)
{
    Client *c;

    if (!reallyDisplaying) {
	return;
    }
    /* Can be NULL if message was from unregistered client */
    if (from == NULL || from->fd == -1) {
	return;
    }
    displayDrawRecv(from, perf);
    if ((c = findClientByFd(from->fd)) != from) {
	displayDrawRecv(c, perf);
    }
}
	
void
displayMessageSend(Client *to, KQMLPerformative *perf)
{
    Client *c;

    if (!reallyDisplaying) {
	return;
    }
    /* Can be NULL if message was to IM itself... */
    if (to == NULL || to->fd == -1) {
	return;
    }
    if ((c = findClientByFd(to->fd)) != to) {
	displayDrawSend(c, perf);
    }
    displayDrawSend(to, perf);
}

static void
displayDrawRecv(Client *from, KQMLPerformative *perf)
{
    DEBUG2("name=%s, recvCount=%d", from->name, from->recvCount);
    /* Increment recv counter for this client */
    from->recvCount += 1;
    /* If first recv, need to draw line */
    if (from->recvCount == 1) {
	XDrawLines(display, canvas, gc[perfToGC(perf)],
		   (XPoint*)(from->recvPts), 3, CoordModeOrigin);
	XSync(XtDisplay(toplevel), False);
    }
    /* Call back later to erase line */
    XtAppAddTimeOut(appcon, (unsigned long)FLASH_MSEC, recvTimerCB, (XtPointer)from);
    /* Keep track of pending timers */
    if (++timeoutCount == 1) {
	/* If first, then we need to spin in doSelect() (timeout in usec) */
	selectSetTimeout(FLASH_MSEC*1000);
    }
    DEBUG0("done");
}

static void
displayDrawSend(Client *to, KQMLPerformative *perf)
{
    DEBUG2("name=%s, sendCount=%d", to->name, to->sendCount);
    /* Increment send counter for this client */
    to->sendCount += 1;
    /* If first send, need to draw line */
    if (to->sendCount == 1) {
	XDrawLines(display, canvas, gc[perfToGC(perf)],
		   (XPoint*)(to->sendPts), 3, CoordModeOrigin);
	XSync(XtDisplay(toplevel), False);
    }
    /* Call back later to erase line */
    XtAppAddTimeOut(appcon, (unsigned long)FLASH_MSEC, sendTimerCB, (XtPointer)to);
    /* Keep track of pending timers */
    if (++timeoutCount == 1) {
	/* If first, then we need to spin in doSelect() (timeout in usec) */
	selectSetTimeout(FLASH_MSEC*1000);
    }
    DEBUG0("done");
}

static void
recvTimerCB(XtPointer client_data, XtIntervalId *timer)
{
    Client *c = (Client*)client_data;

    DEBUG2("name=%s, recvCount=%d", c->name, c->recvCount);
    /* Decrement recv counter for this client */
    if (--(c->recvCount) < 0) {
	c->recvCount = 0;
    }
    /* If no more outstanding recv's for client, erase the line */
    if (c->recvCount == 0) {
	XDrawLines(display, canvas, gc[GC_BACKGROUND],
		   (XPoint*)(c->recvPts), 3, CoordModeOrigin);
	XSync(XtDisplay(toplevel), False);
	/* And if check if we need to handle a deferred deletion */
	if (c->state == IM_EOF && c->sendCount == 0 &&
	    c->listeners == NULL && c->monitors == NULL) {
	    deleteClient(c);
	}
    }
    /* Decrement total timeout counter */
    if (--timeoutCount < 0) {
	timeoutCount = 0;
    }
    /* If no more outstanding timers, don't spin in doSelect() */
    if (timeoutCount == 0) {
	selectSetTimeout(-1);
    }
    DEBUG0("done");
}

static void
sendTimerCB(XtPointer client_data, XtIntervalId *timer)
{
    Client *c = (Client*)client_data;

    DEBUG2("name=%s, sendCount=%d", c->name, c->sendCount);
    /* Decrement send counter for this client */
    if (--(c->sendCount) < 0) {
	c->sendCount = 0;
    }
    /* If no more outstanding send's for client, erase the line */
    if (c->sendCount == 0) {
	XDrawLines(display, canvas, gc[GC_BACKGROUND],
		   (XPoint*)(c->sendPts), 3, CoordModeOrigin);
	XSync(XtDisplay(toplevel), False);
	/* And if check if we need to handle a deferred deletion */
	if (c->state == IM_EOF && c->recvCount == 0 &&
	    c->listeners == NULL && c->monitors == NULL) {
	    deleteClient(c);
	}
    }
    /* Decrement total timeout counter */
    if (--timeoutCount < 0) {
	timeoutCount = 0;
    }
    /* If no more outstanding timers, don't spin in doSelect() */
    if (timeoutCount == 0) {
	selectSetTimeout(-1);
    }
    DEBUG0("done");
}

static GCSelector
perfToGC(KQMLPerformative *perf)
{
    if (STREQ(KQML_VERB(perf), "error")) {
	return GC_RED;
    } else {
	return GC_GREEN;
    }
}

/*	-	-	-	-	-	-	-	-	*/

static Pixmap
readPixmap(char *filename)
{
    char fullname[MAXPATHLEN], *s;
    XpmAttributes attrs;
    Pixmap pixmap;
    int result;

    /* Tolerant color matching */
    attrs.closeness = 40000;
    attrs.valuemask = XpmCloseness;
    /* Try to read from given filename first */
    result = XpmReadFileToPixmap(display, DefaultRootWindow(display),
				 filename, &pixmap, NULL, &attrs);
    if (result == XpmOpenFailed) {
	/* Failed, so try in TRAINS_BASE/etc */
	if ((s=getenv("TRAINS_BASE")) == NULL) {
	  s = TRAINS_BASE;
	}
	sprintf(fullname, "%s/etc/%s", s, filename);
	result = XpmReadFileToPixmap(display, DefaultRootWindow(display),
				     fullname, &pixmap, NULL, &attrs);
    }
    switch (result) {
      case XpmSuccess:
	return pixmap;
      case XpmColorError:
	ERROR1("couldn't allocate exact colors for XPM file: \"%s\"",filename);
	return pixmap;
      case XpmOpenFailed:
	ERROR1("couldn't open XPM file: \"%s\"", filename);
	break;
      case XpmFileInvalid:
 	ERROR1("invalid XPM file: \"%s\"",filename);
	break;
      case XpmNoMemory:
	ERROR1("no memory for XPM file: \"%s\"",filename);
	break;
      case XpmColorFailed:
	ERROR1("couldn't allocate colors for XPM file: \"%s\"",filename);
	break;
      default:
	ERROR1("unknown XPM error: \"%s\"",filename);
	break;
    }
    return None;
}

