/*
 * display.c : Display for Keyboard Manager
 *
 * George Ferguson, ferguson@cs.rochester.edu, 17 Jul 1996
 * Time-stamp: <Mon Nov 18 14:09:57 EST 1996 ferguson>
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <Xm/Xm.h>
#include <Xm/RowColumn.h>
#include <Xm/PushBG.h>
#include <Xm/CascadeB.h>
#include <Xm/Text.h>
#include "trlib/input.h"
#include "util/error.h"
#include "util/debug.h"
#include "display.h"
#include "send.h"
#include "recv.h"
#include "wordbuf.h"
#include "main.h"

/* Defaults for fonts */
#define FONT_PATTERN "-adobe-courier-medium-r-*-*-%d-*-*-*-*-*-*-*"
#define DEFAULT_SIZE 14

/*
 * Functions defined here:
 */
void displayInit(int argc, char **argv);
void displayEventLoop(void);
void displayClose(void);
void displayReset(void);
void displayHideWindow(void);
void displayShowWindow(void);
void displayGrabKeyboard(void);
void displayUngrabKeyboard(void);
void displayAddText(char *text);
static void quitAction(Widget w, XEvent *event,
		       String *params, Cardinal *numparams);
static void iconifyAction(Widget w, XEvent *event,
			  String *params, Cardinal *numparams);
static void spaceAction(Widget w, XEvent *event,
			String *params, Cardinal *numparams);
static void returnAction(Widget w, XEvent *event,
			 String *params, Cardinal *numparams);
static void backspaceAction(Widget w, XEvent *event,
			    String *params, Cardinal *numparams);
static void speechStartAction(Widget w, XEvent *event,
			      String *params, Cardinal *numparams);
static void speechStopAction(Widget w, XEvent *event,
			     String *params, Cardinal *numparams);
static void displayInitActions(void);
static void displayInitMenus(void);
static void displayInitWidgets(void);
static void displayInitHotkey(void);
static void initControlMenu(Widget menubar);
static void initFontMenu(Widget menubar);
static void grabCB(Widget w, XtPointer client_data, XtPointer call_data);
static void quitCB(Widget w, XtPointer client_data, XtPointer call_data);
static void fontCB(Widget w, XtPointer client_data, XtPointer call_data);
static XFontStruct *getFont(int ptsize);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);

/*
 * Data defined here:
 */
static XtAppContext appcon;
static Widget toplevel;
static Widget textW;
static XmTextPosition lastReturnPos;

/* Resources */
typedef struct _AppResources_s {
    int rows;
    int columns;
    Boolean grab;
    Boolean showMenus;
    String fontpat;
    int fontsize;
    String hotkey;
    int buflen;
} AppResources;
static AppResources appres;

static XtResource resources[] = {
    { "rows", "Rows", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,rows), XtRImmediate, (XtPointer)7 },
    { "columns", "Columns", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,columns), XtRImmediate, (XtPointer)80 },
    { "grab", "Grab", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,grab), XtRImmediate, (XtPointer)True },
    { "showMenus", "ShowMenus", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showMenus), XtRImmediate, (XtPointer)True },
    { "fontpat", "FontPat", XtRString, sizeof(String),
      XtOffsetOf(AppResources,fontpat), XtRImmediate, FONT_PATTERN },
    { "fontsize", "FontSize", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,fontsize),XtRImmediate,(XtPointer)DEFAULT_SIZE },
    { "hotkey", "Hotkey", XtRString, sizeof(String),
      XtOffsetOf(AppResources,hotkey), XtRImmediate, "Alt_L" },
    { "buflen", "Buflen", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,buflen),XtRImmediate,(XtPointer)2 },
};
static XrmOptionDescRec options[] = {
    { "-rows",		".rows",		XrmoptionSepArg },
    { "-columns",	".columns",		XrmoptionSepArg },
    { "-grab",		".grab",		XrmoptionSepArg },
    { "-showMenus",	".showMenus",		XrmoptionSepArg },
    { "-fontpat",	".fontpat",		XrmoptionSepArg },
    { "-fontsize",	".fontsize",		XrmoptionSepArg },
    { "-hotkey",	".hotkey",		XrmoptionSepArg },
    { "-buflen",	".buflen",		XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			TRAINS Keyboard Manager",
    "*geometry:			+0-0",
    "*background:		grey75",
    "*FontList:			*helvetica-bold-r-*-*-12*",
    "*XmText.translations:#override\\n\
	<Key>Return:          newline() Return()\\n\
	<Key>0x20:            self-insert() Space()\\n\
	<Key>BackSpace:       Backspace()\\n\
	<Key>Delete:          Backspace()\\n",
    NULL
};

/*	-	-	-	-	-	-	-	-	*/

void
displayInit(int argc, char **argv)
{
    DEBUG0("initializing display");
    toplevel = XtVaAppInitialize(&appcon, "TRAINS",
				 options, XtNumber(options),
				 &argc, argv, fallbackResources,
				 NULL);
    XtGetApplicationResources(toplevel, (XtPointer)&appres,
			      resources, XtNumber(resources), NULL, 0);
    wordbufSetBufferLen(appres.buflen);
    displayInitActions();
    displayInitWidgets();
    displayInitHotkey();
    XtRealizeWidget(toplevel);
    /* Catch iconifications */
    XtOverrideTranslations(toplevel, XtParseTranslationTable("<Prop>WM_STATE: Iconify()"));
    DEBUG0("done");
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
displayClose(void)
{
    XtDestroyApplicationContext(appcon);
}

void
displayReset(void)
{
    XmTextSetString(textW, "");
    wordbufReset();
    lastReturnPos = (XmTextPosition)0;
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

void
displayGrabKeyboard(void)
{
    int ret;
    char *msg;

    DEBUG0("grabbing keyboard");
    ret = XGrabKeyboard(XtDisplay(textW), XtWindow(textW), True,
			GrabModeAsync, GrabModeAsync, CurrentTime);
    if (ret != GrabSuccess) {
	switch (ret) {
	  case AlreadyGrabbed:
	    msg = "already grabbed";
	    break;
	  case GrabNotViewable:
	    msg = "not viewable";
	    break;
	  case GrabFrozen:
	    msg = "frozen";
	    break;
	  case GrabInvalidTime:
	    msg = "invalid time";
	    break;
	}
	ERROR1("couldn't grab keyboard: %s", msg);
    }
    DEBUG0("done");
}

void
displayUngrabKeyboard(void)
{
    DEBUG0("ungrabbing keyboard");
    XUngrabKeyboard(XtDisplay(textW), CurrentTime);
    DEBUG0("done");
}

void
displayAddText(char *text)
{
    XmTextPosition pos = XmTextGetLastPosition(textW);

    XmTextInsert(textW, pos, text);
    /* Note: We don't call the processing callbacks, although we could */
}

/*	-	-	-	-	-	-	-	-	*/

static void
quitAction(Widget w, XEvent *event, String *params, Cardinal *numparams)
{
    programExit(0);
}

/*
 * It would be nice if XtGetValues worked on the XtNiconic resource...
 */
static void
iconifyAction(Widget w, XEvent *event, String *params, Cardinal *numparams)
{
    static Atom WM_STATE = (Atom)0;
    int state;

    DEBUG0("");
    if (appres.grab == False) {
	DEBUG0("done; not grabbing due to resource");
	return;
    }
    if (WM_STATE == (Atom)0) {
	WM_STATE = XInternAtom(XtDisplay(toplevel), "WM_STATE", False);
    }
    if (event->xproperty.state == PropertyNewValue &&
	event->xproperty.atom == WM_STATE) {
	Atom actual_type;
	int actual_format;
	unsigned long nitems = 0, bytes_after = 0;
	unsigned char* data = NULL;

	if (XGetWindowProperty(XtDisplay(toplevel), XtWindow(toplevel),
			       WM_STATE, 0, 2, False, AnyPropertyType,
			       &actual_type, &actual_format,
			       &nitems, &bytes_after, &data) == Success) {
	    state = *(int *)data;
	    DEBUG1("state=%d", state);
	    if (state == NormalState) {
		displayGrabKeyboard();
	    } else {
		displayUngrabKeyboard();
	    }
	    XFree((char *)data);
	}
    }
    DEBUG0("done");
}

static void
spaceAction(Widget w, XEvent *event, String *params, Cardinal *numparams)
{
    char *s;

    DEBUG0("");
    s = XmTextGetString(textW);
    wordbufOutput(s+lastReturnPos, 0);
    XtFree(s);
    DEBUG0("done");
}

static void
returnAction(Widget w, XEvent *event, String *params, Cardinal *numparams)
{
    char *s;

    DEBUG0("");
    s = XmTextGetString(textW);
    wordbufOutput(s+lastReturnPos, 1);
    XtFree(s);
    sendMsg("(end)");
    wordbufReset();
    lastReturnPos = XmTextGetInsertionPosition(textW);
    DEBUG0("done");
}

static void
backspaceAction(Widget w, XEvent *event, String *params, Cardinal *numparams)
{
    DEBUG0("");
    if (XmTextGetInsertionPosition(w) > lastReturnPos) {
	XtCallActionProc(w, "delete-previous-character",
			 event, params, *numparams);
    }
    DEBUG0("done");
}

static void
speechStartAction(Widget w, XEvent *event, String *params, Cardinal *numparams)
{
    DEBUG0("");
    sendSpeechMsg("(start)");
    DEBUG0("done");
}

static void
speechStopAction(Widget w, XEvent *event, String *params, Cardinal *numparams)
{
    DEBUG0("");
    sendSpeechMsg("(stop)");
    DEBUG0("done");
}

static XtActionsRec actionTable[] = {
    { "Quit",		quitAction },
    { "Iconify",	iconifyAction },
    { "Return",		returnAction },
    { "Space",		spaceAction },
    { "Backspace",	backspaceAction },
    { "SpeechStart",	speechStartAction },
    { "SpeechStop",	speechStopAction },
};

static void
displayInitActions(void)
{
    XtAppAddActions(appcon, actionTable, XtNumber(actionTable));
}    

/*	-	-	-	-	-	-	-	-	*/

static void
displayInitWidgets(void)
{
    Widget panel, menubar = NULL;
    Arg args[4];
    int n;

    /* Vert RC */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    XtSetArg(args[n], XmNmarginWidth, 0); n++;
    panel = XmCreateWorkArea(toplevel, "rc", args, n);
    XtManageChild(panel);
    /* Menu bar */
    if (appres.showMenus) {
	n = 0;
	XtSetArg(args[n], XmNmarginHeight, 0); n++;
	XtSetArg(args[n], XmNmarginWidth, 0); n++;
	menubar = XmCreateMenuBar(panel, "menubar", args, n);
	XtManageChild(menubar);
	initControlMenu(menubar);
	initFontMenu(menubar);
	/* Fake button for hotkey label */
	if (appres.hotkey && *(appres.hotkey)) {
	    char label[256];
	    XmString labstr;
	    Widget button;
	    sprintf(label, "Use `%s' for speech", appres.hotkey);
	    labstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
	    n = 0;
	    XtSetArg(args[n], XmNlabelString, labstr); n++;
	    button = XmCreateCascadeButton(menubar, "hotkey", args, n);
	    XtManageChild(button);
	    XmStringFree(labstr);
	    XtVaSetValues(menubar, XmNmenuHelpWidget, button, NULL);
	}
    }
    /* Text window */
    n = 0;
    XtSetArg(args[n], XmNrows, appres.rows); n++;
    XtSetArg(args[n], XmNcolumns, appres.columns); n++;
    XtSetArg(args[n], XmNwordWrap, True); n++;
    XtSetArg(args[n], XmNeditMode, XmMULTI_LINE_EDIT); n++;
    textW = XmCreateScrolledText(panel, "text", args, n);
    /* Set the text window font from resources */
    fontCB(textW, (XtPointer)(appres.fontsize), NULL);
    /* Then go ahead and manage it */
    XtManageChild(textW);
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * This sets translations for the hotkey and makes it non-repeating.
 * We should probably try to clean up after and rest this, but who cares.
 */
static void
displayInitHotkey(void)
{
    char trans[256];
    KeySym keysym;
    KeyCode keycode;
    XKeyboardControl values;
    unsigned long value_mask;
    Display *display = XtDisplay(textW);

    DEBUG0("");
    if (!appres.hotkey || !*(appres.hotkey)) {
	DEBUG0("no hotkey");
	return;
    }
    /* Set translations on text window for hotkey */
    DEBUG0("setting text window translations");
    sprintf(trans, "<KeyDown>%s: SpeechStart()\n<KeyUp>%s: SpeechStop()",
	    appres.hotkey, appres.hotkey);
    XtOverrideTranslations(textW, XtParseTranslationTable(trans));
#ifdef undef_since_it_doesnt_work_anyway
    /* Make hotkey non-repeating */
    if ((keysym = XStringToKeysym(appres.hotkey)) == NoSymbol) {
	ERROR1("no keysym for hotkey \"%s\"", appres.hotkey);
    } else if ((keycode = XKeysymToKeycode(display, keysym)) == 0) {
	ERROR2("no keycode for hotkey \"%s\" (keysym=0x%02x)",
	       appres.hotkey, keysym);
    } else {
	DEBUG3("hotkey \"%s\", keysym=0x%04x, keycode=0x%02x",
	       appres.hotkey, keysym, keycode);
	values.key = keycode;
	values.auto_repeat_mode = AutoRepeatModeOff;
	value_mask = KBKey & KBAutoRepeatMode;
	XChangeKeyboardControl(display, value_mask, &values);
    }
#endif
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
initControlMenu(Widget menubar)
{
    Widget menu, button;
    unsigned char *labstr;
    Arg args[3];
    int n;

    n = 0;
    menu = XmCreatePulldownMenu(menubar, "control", args, n);
    /* Grab */
    labstr = XmStringCreate("Grab Keyboard", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'G'); n++;
    button = XmCreatePushButtonGadget(menu, "grab", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, grabCB, (XtPointer)1);
    XmStringFree(labstr);
    /* Ungrab */
    labstr = XmStringCreate("Ungrab Keyboard", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'U'); n++;
    button = XmCreatePushButtonGadget(menu, "ungrab", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, grabCB, (XtPointer)0);
    XmStringFree(labstr);
    /* Quit */
    labstr = XmStringCreate("Quit", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'Q'); n++;
    button = XmCreatePushButtonGadget(menu, "quit", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, quitCB, NULL);
    XmStringFree(labstr);
    /* Add to menubar */
    labstr = XmStringCreate("Control", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'C'); n++;
    XtSetArg(args[n], XmNsubMenuId, menu); n++;
    button = XmCreateCascadeButton(menubar, "control", args, n);
    XtManageChild(button);
    XmStringFree(labstr);
}

static struct {
    char *label;
    int size;
} fonts[] = {
    { "Tiny",	8 },
    { "Small",	12 },
    { "Normal",	14 },
    { "Large",	18 },
    { "Larger",	20 },
    { "Huge",	24 },
    { "Huger",	36 },
    { NULL,	0 }
};

static void
initFontMenu(Widget menubar)
{
    Widget menu, button;
    unsigned char *labstr;
    Arg args[3];
    int n, i;

    n = 0;
    menu = XmCreatePulldownMenu(menubar, "control", args, n);
    /* Font buttons */
    for (i=0; fonts[i].label != NULL; i++) {
	labstr = XmStringCreate(fonts[i].label, XmSTRING_DEFAULT_CHARSET);
	n = 0;
	XtSetArg(args[n], XmNlabelString, labstr); n++;
	button = XmCreatePushButtonGadget(menu, "fontsize", args, n);
	XtManageChild(button);
	XtAddCallback(button, XmNactivateCallback, fontCB,
		      (XtPointer)fonts[i].size);
	XmStringFree(labstr);
    }
    /* Add to menubar */
    labstr = XmStringCreate("Font", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'F'); n++;
    XtSetArg(args[n], XmNsubMenuId, menu); n++;
    button = XmCreateCascadeButton(menubar, "font", args, n);
    XtManageChild(button);
    XmStringFree(labstr);
}

/*	-	-	-	-	-	-	-	-	*/

static void
grabCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    int grab = (int)client_data;
     
    DEBUG1("grab=%d", grab);
    if (grab) {
	displayGrabKeyboard();
    } else {
	displayUngrabKeyboard();
    }
    DEBUG0("done");
}

static void
quitCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    programExit(0);
}

static void
fontCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    int ptsize = (int)client_data;
    XFontStruct *fs;
    XmFontList fl;
    
    if ((fs=getFont(ptsize)) != NULL &&
	(fl=XmFontListCreate(fs, XmSTRING_DEFAULT_CHARSET)) != NULL) {
	XtVaSetValues(textW, XmNfontList, fl, NULL);
    }
}

/*	-	-	-	-	-	-	-	-	*/

static XFontStruct *
getFont(int ptsize)
{
    static char *fontname = NULL;
    XFontStruct *fs;

    if (fontname == NULL) {
	if ((fontname = malloc(strlen(appres.fontpat)+4)) == NULL) {
	    SYSERR0("couldn't malloc for fontname");
	    return;
	}
    }
    sprintf(fontname, appres.fontpat, ptsize);
    if ((fs = XLoadQueryFont(XtDisplay(toplevel), fontname)) == NULL) {
	ERROR1("couldn't load font \"%s\"", fontname); 
	fs = XLoadQueryFont(XtDisplay(toplevel), "*");
    }
    return fs;
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
