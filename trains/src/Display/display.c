/*
 * display.c : Display for TRAINS-96
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Nov 1994
 * Time-stamp: <96/10/28 09:57:28 ferguson>
 */

#include <stdio.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Xaw/Form.h>
#include <X11/Xaw/MenuButton.h>
#include <X11/Xaw/SimpleMenu.h>
#include <X11/Xaw/SmeBSB.h>
#include <X11/Xaw/Simple.h>
#include <X11/Xaw/AsciiText.h>
#include "trlib/input.h"
#include "util/debug.h"
#include "display.h"
#include "mapfile.h"				/* readMapFile() */
#include "dialog.h"				/* hide/unhideAllDialogs() */
#include "mouse.h"				/* button*() */
#include "recv.h"

#ifndef DEFAULT_MAP
# define DEFAULT_MAP "northeast.map"
#endif

/* #define DEMO /* Enables "Plan" menu for Simulated Dialogue II */

/*
 * Functions defined here
 */
void displayInit(int *argcp, char **argv);
void displayReadMapFile(void);
void displayEventLoop(void);
void displayClose(void);
void displayRedraw(void);
void displayRestart(void);
void displaySay(char *str);
void displaySetCanvas(char *name, int width, int height, char *bgfile);
void displayGetCanvasAttrs(char **name, int *widthp, int *heightp,
			   int *xdpip, int *ydpip);
void displayFlushText(void);
TimerId displayStartTimer(unsigned long usecs,
			  TimerCallbackProc proc, void *data);
void displayStopTimer(TimerId id);
void displayHideWindow(void);
void displayShowWindow(void);

static void initGraphics(int *argcp, char **argv);
static void cleanupGCs(void);
static void initMenus(void);
static void initActions(void);
static void initWidgets(int width, int height);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);

#ifdef DEBUG
static int xerror(Display *display, XErrorEvent *event);
#endif

/*
 * Data defined here:
 */
typedef struct {
    String mapFile;
    Boolean showMenus;
    Boolean showTextOut;
    Boolean showTextIn;
    int textOutHeight;
    int textInHeight;
    float scaleX, scaleY, scale;
} AppResources;
static AppResources appres;
static XtResource resources[] = {
    { "mapFile", "MapFile", XtRString, sizeof(String),
      XtOffsetOf(AppResources,mapFile), XtRImmediate, DEFAULT_MAP },
    { "showMenus", "Show", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showMenus), XtRImmediate, (XtPointer)True },
    { "showTextOut", "Show", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showTextOut), XtRImmediate, (XtPointer)True },
    { "showTextIn", "Show", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showTextIn), XtRImmediate, (XtPointer)False },
    { "textOutHeight", "Height", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,textOutHeight), XtRImmediate, (XtPointer)20 },
    { "textInHeight", "Height", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,textInHeight), XtRImmediate, (XtPointer)100 },
    { "scaleX", "ScaleX", XtRFloat, sizeof(float),
      XtOffsetOf(AppResources,scaleX), XtRString, "0" },
    { "scaleY", "ScaleY", XtRFloat, sizeof(float),
      XtOffsetOf(AppResources,scaleY), XtRString, "0" },
    { "scale", "Scale", XtRFloat, sizeof(float),
      XtOffsetOf(AppResources,scale), XtRString, "0" },
};
static XrmOptionDescRec options[] = {
    { "-map",	  	".mapFile",	XrmoptionSepArg },
    { "-showMenus",  	".showMenus",	XrmoptionSepArg },
    { "-showTextOut",  	".showTextOut",	XrmoptionSepArg },
    { "-showTextIn",  	".showTextIn",	XrmoptionSepArg },
    { "-textOutHeight", ".textOutHeight",XrmoptionSepArg },
    { "-textInHeight", 	".textInHeight",XrmoptionSepArg },
    { "-scaleX",	".scaleX",	XrmoptionSepArg },
    { "-scaleY",	".scaleY",	XrmoptionSepArg },
    { "-scale",		".scale",	XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			TRAINS Display",
    "*geometry:			+0+0",
    "*background:		grey75",
    "TRAINS.translations:#override\\n\
		<Message>WM_PROTOCOLS:	Quit()",
    "*undoButton.foreground:	red",
    "*text*background:		grey80",
    "*goalShell.geometry:	-250+389",
    "*confirm*Label.Font:    -adobe-helvetica-medium-r-*-*-24-*-*-*-*-*-*-*",
    NULL
};
/* Used for word buffering... */
static XawTextPosition lastReturnPos;

/*	-	-	-	-	-	-	-	-	*/

Display *display;
Screen *screen;
int screenum;
Colormap colormap;
Window root,canvas;
XtAppContext appcon;
Widget toplevel, canvasW;
static Widget textoutW, textinW;
int bghack;
float scaleX = 1.0, scaleY = 1.0;

void
displayInit(int *argcp, char **argv)
{
    initGraphics(argcp,argv);
    initMenus();
    initActions();
    /* Note: the widgets won't be realized until initWidgets() is called! */
}

void
displayReadMapFile(void)
{
    readMapFile(appres.mapFile);
}

void
displayEventLoop(void)
{
    DEBUG0("registering stdin");
    /* Register to be called back when input available */
    XtAppAddInput(appcon, 0, (XtPointer)XtInputReadMask, stdinCB, NULL);
    DEBUG0("calling XtAppMainLoop...");
    XtAppMainLoop(appcon);
    DEBUG0("done");
}

void
displayClose()
{
#ifdef undef
    destroyObjects();
    cleanupGCs();
    cleanupColors();
#endif
    XtDestroyApplicationContext(appcon);
}

void
displayRedraw()
{
    DEBUG0("clearing window");
    XClearWindow(display,canvas);
    DEBUG0("displaying objects");
    displayObjects();
    /* Force out X events, we hope */
    DEBUG0("syncing display");
    XSync(XtDisplay(toplevel), False);
    DEBUG0("done");
}

void
displayRestart(void)
{
    XClearWindow(display,canvas);
    destroyObjects();
    readMapFile(appres.mapFile);
    displayObjects();
    if (textoutW) {
	XtVaSetValues(textoutW, XtNstring, "", NULL);
    }
    if (textinW) {
	XtVaSetValues(textinW, XtNstring, "", NULL);
	wordbufReset();
	lastReturnPos = (XawTextPosition)0;
    }
}

void
displaySay(char *str)
{
    XawTextBlock block;
    XawTextPosition pos;
    XawTextEditType oldtype;

    if (!textoutW) {
	return;
    }
    if ((block.length=strlen(str)) == 0)
	return;
    block.firstPos = 0;
    block.format = FMT8BIT;
    block.ptr = str;
    XtVaGetValues(textoutW,XtNeditType,&oldtype,NULL);
    XtVaSetValues(textoutW,XtNeditType,XawtextAppend,NULL);
    XtCallActionProc(textoutW,"newline",NULL,NULL,0);
    pos = XawTextGetInsertionPoint(textoutW);
    XawTextReplace(textoutW,pos,pos,&block);
    XtVaSetValues(textoutW,XtNeditType,oldtype,NULL);
#ifdef undef
    XBell(display,0);
#endif
}

void
displaySetCanvas(char *name, int width, int height, char *bgfile)
{
    Pixmap pixmap;
    Dimension ch,cw;
    
    if (name != NULL) {
	XtVaSetValues(toplevel,XtNtitle,name,NULL);
    }
    if (canvasW == NULL) {
	initWidgets(width, height);
    } else {
	XtVaGetValues(canvasW, XtNwidth, &cw, XtNheight, &ch, NULL);
	if (width != cw || height != ch) {
	    XtVaSetValues(canvasW, XtNwidth, width, XtNheight, height, NULL);
	    XtVaGetValues(canvasW,XtNbackgroundPixmap,&pixmap,NULL);
	    if (pixmap != XtUnspecifiedPixmap) {
		XFreePixmap(display, pixmap);
		XtVaSetValues(canvasW,
			      XtNbackgroundPixmap,XtUnspecifiedPixmap,NULL);
	    }
	    if (textinW) {
		XtVaSetValues(textinW, XtNwidth, width, NULL);
	    }
	    if (textoutW) {
		XtVaSetValues(textoutW, XtNwidth, width, NULL);
	    }
	}
	XtVaGetValues(canvasW, XtNwidth, &cw, XtNheight, &ch, NULL);
    }
}

void
displayGetCanvasAttrs(char **namep, int *widthp, int *heightp,
		      int *xdpip, int *ydpip)
{
    Dimension w,h;

    XtVaGetValues(toplevel, XtNtitle, namep, NULL);
    XtVaGetValues(canvasW, XtNwidth, &w, XtNheight, &h, NULL);
    *widthp = (int)w;
    *heightp = (int)h;
    *xdpip = (int)((((double)WidthOfScreen(screen)) * 25.4) /
		   ((double)(WidthMMOfScreen(screen))));
    *ydpip = (int)((((double)HeightOfScreen(screen)) * 25.4) /
		   ((double)(HeightMMOfScreen(screen))));
}

void
displaySetBackground(void)
{
    Pixmap bgpix;
    Dimension wd, ht;
    int dp;

    /* Get size of canvas and bg pixmap */
    XtVaGetValues(canvasW,
		  XtNwidth, &wd, XtNheight, &ht, XtNdepth, &dp,
		  XtNbackgroundPixmap, &bgpix, NULL);
    /* If none, create one */
    if (bgpix == XtUnspecifiedPixmap) {
	bgpix = XCreatePixmap(display, root, wd, ht, dp);
	XFillRectangle(display, bgpix, XDefaultGCOfScreen(screen),
		       0, 0, wd, ht);
    }
    /* Go draw everything into the pixmap */
    canvas = bgpix;
    bghack = 1;
    displayObjects();
    bghack = 0;
    canvas = XtWindow(canvasW);
    /* Reset the bg pixmap */
    XtVaSetValues(canvasW, XtNbackgroundPixmap, bgpix, NULL);
}

void
displaySetMap(char *file)
{
    appres.mapFile = XtNewString(file);
    displayRestart();
}

TimerId
displayStartTimer(unsigned long millisecs, TimerCallbackProc proc, void *data)
{
    return (TimerId)XtAppAddTimeOut(appcon,millisecs,proc,data);
}

void
displayStopTimer(TimerId id)
{
    XtRemoveTimeOut((XtIntervalId)id);
}

#ifdef undef
static Position savedx = -1, savedy = -1;
#endif

void
displayHideWindow(void)
{
    /* Hide children */
    hideAllDialogs();
#ifdef undef
    /* Save current position */
    XtVaGetValues(toplevel, XtNx, &savedx, XtNy, &savedy, NULL);
    /* Remove window */
    XtUnmapWidget(toplevel);
#endif
    XtVaSetValues(toplevel, XtNiconic, True, NULL);
}

void
displayShowWindow(void)
{
#ifdef undef
    /* Restore window */
    XtMapWidget(toplevel);
    /* Restore position (if any) */
    if (savedx != -1) {
	XtVaSetValues(toplevel, XtNx, savedx, XtNy, savedy, NULL);
    }
#endif
    /* Clear text items between runs */
    if (textinW) {
	XtVaSetValues(textinW, XtNstring, "", NULL);
    }
    if (textoutW) {
	XtVaSetValues(textoutW, XtNstring, "", NULL);
    }
    /* Reset the input word buffer */
    wordbufReset();
    /* Show the window */
    XtVaSetValues(toplevel, XtNiconic, False, NULL);
    /* Unhide children */
    unhideAllDialogs();
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Display setup
 */

static void
initGraphics(int *argcp, char **argv)
{
    toplevel = XtVaAppInitialize(&appcon,"TRAINS",options,XtNumber(options),
				 (Cardinal *)argcp,argv,fallbackResources,
				 XtNtitle, "TRAINS Display",
				 XtNallowShellResize, True,
				 NULL);
    display = XtDisplay(toplevel);
    screen = XtScreen(toplevel);
    colormap = DefaultColormapOfScreen(screen);
    root = RootWindowOfScreen(screen);
    XtGetApplicationResources(toplevel,(XtPointer)&appres,
			      resources,XtNumber(resources),NULL,0);
    /* Set globals from app resources */
    if (appres.scale != 0) {
	scaleX = scaleY = appres.scale;
    } else {
	if (appres.scaleX != 0) {
	    scaleX = appres.scaleX;
	}
	if (appres.scaleY != 0) {
	    scaleY = appres.scaleY;
	}
    }
#ifdef DEBUG
    XSetErrorHandler(xerror);
#ifdef undef
    /* This is necessary for proper debugging, but kills the arc drawer
     * (and any other X-intensive operations).
     */
    XSynchronize(display,True);
#endif
#endif
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Menus
 */

typedef struct _MenuInfo_s {
    char *name;
    XtCallbackProc callback;
} MenuInfo;

static void
quitCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    sendMsg("(menu quit)");
}

static void
restartCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    sendMsg("(menu restart)");
}

static MenuInfo controlMenuInfo[] = {
    "Restart",			restartCB,
    "Quit    [M-q]",		quitCB,
};

static void
showParserCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    /* Should be MENU, I know, but we set the spec for this hack before
     * I thought about it...
     */
    sendMsg("(mouse :button :parse-tree)");
}

static MenuInfo viewMenuInfo[] = {
    "Show Parser Output",	showParserCB,
};

#ifdef DEMO
static void
showOrdersCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    system("/u/ferguson/research/tt/Demo/orders.sh &");
}

static MenuInfo planMenuInfo[] = {
    "Suggest Action     >",	NULL,
    "Suggest Object     >",	NULL,
    "Suggest Constraint >",	NULL,
    "--------------------",	NULL,
    "Show Orders",		showOrdersCB,
    "Show Schedule",		NULL,
    "Show Costs",		NULL,
};
#endif

static void
initMenus(void)
{
    Widget menu,item;
    int i;

    menu = XtCreatePopupShell("controlMenu",simpleMenuWidgetClass,
			      toplevel,NULL,0);
    for (i=0; i < XtNumber(controlMenuInfo); i++) {
	item = XtCreateManagedWidget(controlMenuInfo[i].name,smeBSBObjectClass,
				     menu,NULL,0);
	if (controlMenuInfo[i].callback) {
	    XtAddCallback(item,XtNcallback,controlMenuInfo[i].callback,NULL);
	}
    }
    menu = XtCreatePopupShell("viewMenu",simpleMenuWidgetClass,
			      toplevel,NULL,0);
    for (i=0; i < XtNumber(viewMenuInfo); i++) {
	item = XtCreateManagedWidget(viewMenuInfo[i].name,smeBSBObjectClass,
				     menu,NULL,0);
	if (viewMenuInfo[i].callback) {
	    XtAddCallback(item,XtNcallback,viewMenuInfo[i].callback,NULL);
	}
    }
#ifdef DEMO
    menu = XtCreatePopupShell("planMenu",simpleMenuWidgetClass,
			      toplevel,NULL,0);
    for (i=0; i < XtNumber(planMenuInfo); i++) {
	item = XtCreateManagedWidget(planMenuInfo[i].name,smeBSBObjectClass,
				     menu,NULL,0);
	if (planMenuInfo[i].callback) {
	    XtAddCallback(item,XtNcallback,planMenuInfo[i].callback,NULL);
	}
    }
#endif
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Action procedures
 */

#define ACTION_PROC(NAME) static void \
    NAME (Widget w, XEvent *event, String *params, Cardinal *numparams)
    
/*
 * Canvas actions
 */
ACTION_PROC(exposeAction)
{
    displayRedraw();
}

ACTION_PROC(canvasInputAction)
{
    switch (event->xany.type) {
      case ButtonPress: {
	  XButtonEvent *xbe = (XButtonEvent*)event;
	  buttonPress(xbe->button, xbe->x, xbe->y);
	  break;
      }
      case MotionNotify: {
	  XMotionEvent *xme = (XMotionEvent*)event;
	  buttonMotion(xme->x, xme->y);
	  break;
      }
      case ButtonRelease: {
	  XButtonEvent *xbe = (XButtonEvent*)event;
	  buttonRelease(xbe->button, xbe->x, xbe->y);
	  break;
      }
    }
}

ACTION_PROC(quitAction)
{
    programExit();
}

/*
 * Text input actions
 */

ACTION_PROC(spaceAction)
{
    char *s;

    XtVaGetValues(w, XtNstring, &s, NULL);
    s += lastReturnPos;
    wordbufOutput(s, 0);
}

ACTION_PROC(returnAction)
{
    char *s;

    XtVaGetValues(w, XtNstring, &s, NULL);
    s += lastReturnPos;
    wordbufOutput(s, 1);
    sendMsg("(end)");
    wordbufReset();
    lastReturnPos = XawTextGetInsertionPoint(w);
}

void
displayFlushText(void)
{
    char *s;

    if (textinW) {
	XtVaGetValues(textinW, XtNstring, &s, NULL);
	s += lastReturnPos;
	wordbufOutput(s, 1);
    }
}

ACTION_PROC(backspaceAction)
{
    if (XawTextGetInsertionPoint(w) > lastReturnPos) {
	XtCallActionProc(w,"delete-previous-character",
			 event,params,*numparams);
    }
}

static XtActionsRec actionTable[] = {
    { "Expose",		exposeAction },
    { "CanvasInput",	canvasInputAction },
    { "Quit",		quitAction },
    { "Return",		returnAction },
    { "Space",		spaceAction },
    { "Backspace",	backspaceAction },
};

static void
initActions(void)
{
    XtAppAddActions(appcon,actionTable,XtNumber(actionTable));
}    

/*	-	-	-	-	-	-	-	-	*/
/*
 * Callbacks
 */

static void
undoCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    sendMsg("(mouse :button :undo)");
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Widgets
 */

static char *canvasTranslations =
    "<Expose>:    Expose()\n\
     <BtnMotion>: CanvasInput()\n\
     <BtnDown>:   CanvasInput()\n\
     <BtnUp>:     CanvasInput()";

static char *textTranslations = 
    "<Key>Return:          newline() Return()\n\
     <Key>0x20:            insert-char() Space()\n\
     Meta<Key>q:	   Quit()\n";

#define DONT_RESIZE	XtNtop, XawChainTop, XtNbottom, XawChainTop, \
			XtNleft, XawChainLeft, XtNright, XawChainLeft
#define RESIZE_HONLY	XtNtop, XawChainTop, XtNbottom, XawChainTop, \
			XtNleft, XawChainLeft, XtNright, XawChainRight

static void
initWidgets(int width, int height)
{
    Widget form, button = NULL;
    XSetWindowAttributes attrs;
    Atom WM_DELETE_WINDOW;

    form = XtVaCreateManagedWidget("form",formWidgetClass,toplevel,NULL);
    if (appres.showMenus) {
	button =
	    XtVaCreateManagedWidget("fileButton",menuButtonWidgetClass,form,
				    XtNlabel, "Control",
				    XtNmenuName, "controlMenu",
				    DONT_RESIZE,
				    NULL);
	button =
	    XtVaCreateManagedWidget("viewButton",menuButtonWidgetClass,form,
				    XtNlabel, "View",
				    XtNmenuName, "viewMenu",
				    XtNfromHoriz, button,
				    DONT_RESIZE,
				    NULL);
#ifdef DEMO
	button =
	    XtVaCreateManagedWidget("planButton",menuButtonWidgetClass,form,
				    XtNlabel, "Plan",
				    XtNmenuName, "planMenu",
				    XtNfromHoriz, button,
				    DONT_RESIZE,
				    NULL);
#endif
	button =
	    XtVaCreateManagedWidget("undoButton",commandWidgetClass,form,
				    XtNlabel, "Undo!",
				    XtNfromHoriz, button,
				    DONT_RESIZE,
				    NULL);
	XtAddCallback(button, XtNcallback, undoCB, NULL);
    }
    if (appres.showTextOut) {
	textoutW =
	    XtVaCreateManagedWidget("say",asciiTextWidgetClass,form,
				    XtNfromVert, button,
				    XtNeditType, XawtextRead,
				    XtNheight, appres.textOutHeight,
				    XtNwidth, width,
				    XtNdisplayCaret, False,
				    XtNscrollVertical, XawtextScrollAlways,
				    XtNstring,"Welcome to TRAINS-96!",
				    XtNresizable, True,
				    RESIZE_HONLY,
				    NULL);
    }
    canvasW = XtVaCreateManagedWidget("canvas",simpleWidgetClass, form,
				      XtNfromVert, textoutW,
				      XtNwidth, width,
				      XtNheight, height,
				      XtNresizable, True,
				      NULL);
    XtOverrideTranslations(canvasW,
			   XtParseTranslationTable(canvasTranslations));
    if (appres.showTextIn) {
	textinW =
	    XtVaCreateManagedWidget("text",asciiTextWidgetClass,form,
				    XtNfromVert, canvasW,
				    XtNeditType, XawtextEdit,
				    XtNheight, appres.textInHeight,
				    XtNwidth, width,
				    XtNscrollVertical, XawtextScrollAlways,
				    XtNresizable, True,
				    RESIZE_HONLY,
				    NULL);
	XtOverrideTranslations(textinW,
			       XtParseTranslationTable(textTranslations));
    }
    /* Realize the widget to create its window */
    XtRealizeWidget(toplevel);
    canvas = XtWindow(canvasW);
    /* Maybe the server can help us redraw the window... */
    attrs.backing_store = 1;
    XChangeWindowAttributes(display,canvas,CWBackingStore,&attrs);
    /* Enable WM_DELETE_WINDOW processing to quit */
    WM_DELETE_WINDOW =
	XInternAtom(XtDisplay(toplevel), "WM_DELETE_WINDOW", False);
    XSetWMProtocols(XtDisplay(toplevel), XtWindow(toplevel),
		    &WM_DELETE_WINDOW, 1);
    /* Force keyboard focus onto text input widget */
    if (textinW) {
	XtSetKeyboardFocus(toplevel, textinW);
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * This is called when there's something ready from the IM.
 */
static void
stdinCB(XtPointer client_data, int *source, XtInputId *id)
{
    int ret;

    if ((ret = trlibInput(*source, TRLIB_DONTBLOCK, receiveMsg)) <= 0) {
	programExit(ret);
    }
}

/*	-	-	-	-	-	-	-	-	*/

#ifdef DEBUG
/*
 * Override default X error handler to force an abort to debugger
 */
static int
xerror(Display *display, XErrorEvent *event)
{
    char buf[256];

    XGetErrorText(display,event->error_code,buf,256);
    fprintf(stderr, "XERROR: %d: %s\n", event->error_code, buf);
    abort();
    return(0);
}
#endif
