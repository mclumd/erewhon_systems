/*
 * display.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 1 Feb 1996
 * Time-stamp: <Mon Dec  9 11:30:45 EST 1996 ferguson>
 *
 * TODO:
 * - Horiz resize works fine, but not vertical (tricky attachments)
 * - Should resize when hide/show changes
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <Xm/Xm.h>
#include <Xm/Form.h>
#include <Xm/RowColumn.h>
#include <Xm/Label.h>
#include <Xm/PushB.h>
#include <Xm/ToggleB.h>
#include <Xm/CascadeB.h>
#include <Xm/Text.h>
#include <Xm/Separator.h>
#include "trlib/input.h"
#include "util/streq.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "display.h"
#include "send.h"
#include "recv.h"
#include "utt.h"
#include "main.h"

/* Defaults for fonts */
#define FONT_PATTERN "-adobe-helvetica-bold-r-*-*-%d-*-*-*-*-*-*-*"
#define DEFAULT_SIZE 18

/*
 * Functions defined here:
 */
void displayInit(int argc, char **argv);
void displayEventLoop(void);
void displayClose(void);
void displayReset(void);
void displayClear(void);
void displayHideWindow(void);
void displayShowWindow(void);
void displaySetButton(int on);
void displayWords(int who, char **words);
void displayUttnum(int uttnum);
void displayDone(int uttnum);
void displayShowStatus(XClient who, XStatus what);
static void initWidgets(void);
static void initControlMenu(Widget menubar);
static void initFontMenu(Widget menubar);
static void quitCB(Widget w, XtPointer client_data, XtPointer call_data);
static void fontCB(Widget w, XtPointer client_data, XtPointer call_data);
static void speechInCB(Widget w, XtPointer client_data, XtPointer call_data);
static void speechPPCB(Widget w, XtPointer client_data, XtPointer call_data);
static void ppOnlineCB(Widget w, XtPointer client_data, XtPointer call_data);
static void hideShowCB(Widget w, XtPointer client_data, XtPointer call_data);
static void startCB(Widget w, XtPointer client_data, XtPointer call_data);
static void stopCB(Widget w, XtPointer client_data, XtPointer call_data);
static void toggleCB(Widget w, XtPointer client_data, XtPointer call_data);
static XFontStruct *getFont(int ptsize);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);

/*
 * Data defined here:
 */
char *listenTo, *sendTo;
static XtAppContext appcon;
static Widget toplevel;
static Widget uttnumW, speechInW, speechPPW, buttonW;
static Widget speechInStatusW, speechPPStatusW;
static Widget speechInFormW, speechPPFormW;
static int lastUttnum = 0;

/* Resources */
typedef struct _AppResources_s {
    Boolean showLabels;
    Boolean showMenus;
    Boolean showSpeechIn;
    Boolean showSpeechPP;
    Boolean showButton;
    int stopDelay;
    int rows;
    int columns;
    String fontpat;
    int fontsize;
    Boolean clickAndHold;
    Pixel red, yellow, green;
    String listenTo;
    String sendTo;
} AppResources;
static AppResources appres;

static XtResource resources[] = {
    { "showLabels", "Display", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showLabels), XtRImmediate, (XtPointer)True },
    { "showMenus", "Display", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showMenus), XtRImmediate, (XtPointer)True },
    { "showSpeechIn", "Display", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showSpeechIn), XtRImmediate, (XtPointer)True },
    { "showSpeechPP", "Display", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showSpeechPP), XtRImmediate, (XtPointer)True },
    { "showButton", "Display", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,showButton), XtRImmediate, (XtPointer)True },
    { "stopDelay", "StopDelay", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,stopDelay), XtRImmediate, (XtPointer)500000 },
    { "rows", "Rows", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,rows), XtRImmediate, (XtPointer)4 },
    { "columns", "Columns", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,columns), XtRImmediate, (XtPointer)25 },
    { "fontpat", "FontPat", XtRString, sizeof(String),
      XtOffsetOf(AppResources,fontpat), XtRImmediate, FONT_PATTERN },
    { "fontsize", "FontSize", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,fontsize),XtRImmediate,(XtPointer)DEFAULT_SIZE },
    { "clickAndHold", "ClickAndHold", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,clickAndHold), XtRImmediate, (XtPointer)True },
    { "red", "Color", XtRPixel, sizeof(Pixel),
      XtOffsetOf(AppResources,red), XtRString, "red" },
    { "yellow", "Color", XtRPixel, sizeof(Pixel),
      XtOffsetOf(AppResources,yellow), XtRString, "yellow" },
    { "green", "Color", XtRPixel, sizeof(Pixel),
      XtOffsetOf(AppResources,green), XtRString, "green" },
    { "listenTo", "ListenTo", XtRString, sizeof(String),
      XtOffsetOf(AppResources,listenTo), XtRString, "speech-rec" },
    { "sendTo", "SendTo", XtRString, sizeof(String),
      XtOffsetOf(AppResources,sendTo), XtRString, "speech-in" },
};
static XrmOptionDescRec options[] = {
    { "-showLabels",	".showLabels",		XrmoptionSepArg },
    { "-showMenus",	".showMenus",		XrmoptionSepArg },
    { "-showSpeechIn",	".showSpeechIn",	XrmoptionSepArg },
    { "-showSpeechPP",	".showSpeechPP",	XrmoptionSepArg },
    { "-showButton",	".showButton",		XrmoptionSepArg },
    { "-stopdelay",	".stopDelay",		XrmoptionSepArg },
    { "-rows",		".rows",		XrmoptionSepArg },
    { "-columns",	".columns",		XrmoptionSepArg },
    { "-fontpat",	".fontpat",		XrmoptionSepArg },
    { "-fontsize",	".fontsize",		XrmoptionSepArg },
    { "-clickAndHold",	".clickAndHold",	XrmoptionSepArg },
    { "-listenTo",	".listenTo",		XrmoptionSepArg },
    { "-sendTo",	".sendTo",		XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			TRAINS Speech Recognition",
    "*geometry:			-114-0",
    "*background:		grey75",
    "*traversalOn:		False",
    "*FontList:			*helvetica-bold-r-*-*-12*",
    /* Main button */
    "*button.height:		50",
    "*button.foreground:	red",
    /* Status buttons */
    "*status.width:		30",
    "*status.height:		15",
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
    listenTo = appres.listenTo;
    sendTo = appres.sendTo;
    initWidgets();
    XtRealizeWidget(toplevel);
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
    uttReset();
    if (speechInW != NULL) {
	XmTextSetString(speechInW, "");
    }
    if (speechPPW != NULL) {
	XmTextSetString(speechPPW, "");
    }
    displayUttnum(0);
}
    
void
displayClear(void)
{
    if (speechInW != NULL) {
	XmTextSetString(speechInW, "");
    }
    if (speechPPW != NULL) {
	XmTextSetString(speechPPW, "");
    }
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
displaySetButton(int on)
{
    if (buttonW) {
	if (on) {
	    XtCallActionProc(buttonW, "Arm", NULL, NULL, 0);
	} else {
	    XtCallActionProc(buttonW, "Disarm", NULL, NULL, 0);
	}
    }
}

#define INITIAL_SIZE	256
#define INCREMENT	256

void
displayWords(int who, char **words)
{
    static char *contents = NULL;
    static int contentslen = 0;
    Widget w;
    char **ww;
    int len;

    DEBUG1("who=%d", who);
    if (who == 0) {
	w = speechInW;
    } else {
	w = speechPPW;
    }
    /* May not exist if we didn't create it */
    if (w == NULL) {
	return;
    }
    /* Count total length of words */
    len = 0;
    for (ww=words; *ww != NULL; ww++) {
	/* Add one for space following word */
	len += strlen(*ww) + 1;
    }
    DEBUG1("%d chars to display", len);
    if (len == 0) {
	return;
    }
    /* Allocate space for contents if needed */
    if (len > contentslen) {
	/* Compute new size */
	while (contentslen < len) {
	    contentslen += INCREMENT;
	}
	/* Free old contents (if any) */
	if (contents != NULL) {
	    free(contents);
	}
	DEBUG1("allocating new contents string, contentslen=%d", contentslen);
	if ((contents = malloc(contentslen)) == NULL) {
	    SYSERR0("couldn't malloc for text contents");
	    contentslen = 0;
	    return;
	}
    }
    /* Now copy the words into the contents string separated by spaces */
    /* Special handling of tokens like "<SIL>" collapses them into
     * sequences of dots.
     */
    len = 0;
    for (ww=words; *ww != NULL; ww++) {
	if (**ww == '<') {
	    strcpy(contents+len, ".");
	    len += 1;
	} else {
	    /* Regular word: add a space if preceeded by dots */
	    if (len > 0 && **(ww-1) == '<') {
		strcpy(contents+len, " ");
		len += 1;
	    }
	    /* Add the word */
	    strcpy(contents+len, *ww);
	    len += strlen(*ww);
	    /* Add a space except for the last word (which puts NUL there) */
	    if (*(ww+1) != NULL) {
		strcpy(contents+len, " ");
		len += 1;
	    }
	}
    }
    /* Set new widget contents */
    XmTextSetString(w, contents);
    DEBUG0("done");
}

void
displayUttnum(int uttnum)
{
    char text[16];
    XmString labstr;

    if (uttnumW == NULL) {
	return;
    }
    sprintf(text, "%d", uttnum);
    labstr = XmStringCreate(text, XmSTRING_DEFAULT_CHARSET);
    XtVaSetValues(uttnumW, XmNlabelString, labstr, NULL);
    XmStringFree(labstr);
}

void
displayDone(int uttnum)
{
    char text[16];
    XmString labstr;

    /* May not exist if we didn't create it */
    if (uttnumW == NULL) {
	return;
    }
    sprintf(text, "%d - done", uttnum);
    labstr = XmStringCreate(text, XmSTRING_DEFAULT_CHARSET);
    XtVaSetValues(uttnumW, XmNlabelString, labstr, NULL);
    XmStringFree(labstr);
}

void
displaySetStatus(XClient who, XStatus what)
{
    Widget w;
    Pixel color;

    switch (who) {
      case CLIENT_SPEECH_IN: w = speechInStatusW; break;
      case CLIENT_SPEECH_PP: w = speechPPStatusW; break;
      default: return;
    }
    /* May not exist if we didn't create it */
    if (w == NULL) {
	return;
    }
    switch (what) {
      case STATUS_RED:		color = appres.red; break;
      case STATUS_YELLOW:	color = appres.yellow; break;
      case STATUS_GREEN:	color = appres.green; break;
      default: return;
    }
    XtVaSetValues(w, XtNbackground, color, XtNforeground, color, NULL);
}

/*	-	-	-	-	-	-	-	-	*/

static void
initWidgets(void)
{
    Widget panel, menubar = NULL, subform, sep, label;
    XmString labstr;
    Arg args[11];
    int n;

    /* Form */
    n = 0;
    panel = XmCreateForm(toplevel, "panel", args, n);
    XtManageChild(panel);
    /* Menu bar */
    if (appres.showMenus) {
	n = 0;
	XtSetArg(args[n], XmNmarginHeight, 0); n++;
	XtSetArg(args[n], XmNmarginWidth, 0); n++;
	XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	menubar = XmCreateMenuBar(panel, "menubar", args, n);
	XtManageChild(menubar);
	initControlMenu(menubar);
	initFontMenu(menubar);
    }
    if (appres.showLabels) {
	/* Utterance counter */
	n = 0;
	if (appres.showMenus) {
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	    XtSetArg(args[n], XmNtopWidget, menubar); n++;
	} else {
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	}
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	subform = XmCreateForm(panel, "subform", args, n);
	XtManageChild(subform);
	n = 0;
	labstr = XmStringCreate("Utterance:", XmSTRING_DEFAULT_CHARSET);
	XtSetArg(args[n], XmNlabelString, labstr); n++;
	XtSetArg(args[n], XmNalignment, XmALIGNMENT_BEGINNING); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	label = XmCreateLabel(subform, "label", args, n);
	XtManageChild(label);
	XmStringFree(labstr);
	n = 0;
	labstr = XmStringCreate("-", XmSTRING_DEFAULT_CHARSET);
	XtSetArg(args[n], XmNlabelString, labstr); n++;
	XtSetArg(args[n], XmNalignment, XmALIGNMENT_BEGINNING); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_WIDGET); n++;
	XtSetArg(args[n], XmNleftWidget, label); n++;
	uttnumW = XmCreateLabel(subform, "uttnum", args, n);
	XtManageChild(uttnumW);
	/* Separator */
	n = 0;
	XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
	XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	XtSetArg(args[n], XmNtopWidget, subform); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	sep = XmCreateSeparator(panel, "sep", args, n);
	XtManageChild(sep);
    }
    /* Speech-in label and button */
    if (appres.showSpeechIn) {
	n = 0;
	XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	XtSetArg(args[n], XmNtopWidget, sep); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	speechInFormW = XmCreateForm(panel, "speechIn", args, n);
	XtManageChild(speechInFormW);
	if (appres.showLabels) {
	    n = 0;
	    labstr = XmStringCreate("Speech-In:", XmSTRING_DEFAULT_CHARSET);
	    XtSetArg(args[n], XmNlabelString, labstr); n++;
	    XtSetArg(args[n], XmNalignment, XmALIGNMENT_BEGINNING); n++;
	    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	    label = XmCreateLabel(speechInFormW, "label", args, n);
	    XtManageChild(label);
	    XmStringFree(labstr);
	    n = 0;
	    labstr = XmStringCreate("", XmSTRING_DEFAULT_CHARSET);
	    XtSetArg(args[n], XmNlabelString, labstr); n++;
	    XtSetArg(args[n], XmNrecomputeSize, False); n++;
	    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	    XtSetArg(args[n], XmNrightOffset, 20); n++;
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	    XtSetArg(args[n], XmNtopOffset, 2); n++;
	    speechInStatusW = XmCreatePushButton(speechInFormW, "status", args, n);
	    XtManageChild(speechInStatusW);
	    XmStringFree(labstr);
	}
	/* Speech-in Text */
	n = 0;
	XtSetArg(args[n], XmNrows, appres.rows); n++;
	XtSetArg(args[n], XmNcolumns, appres.columns); n++;
	XtSetArg(args[n], XmNwordWrap, True); n++;
	XtSetArg(args[n], XmNeditMode, XmMULTI_LINE_EDIT); n++;
	XtSetArg(args[n], XmNscrollHorizontal, False); n++;
	XtSetArg(args[n], XmNcursorPositionVisible, False); n++;
	if (appres.showLabels) {
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	    XtSetArg(args[n], XmNtopWidget, label); n++;
	} else {
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	}
	XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	speechInW = XmCreateScrolledText(speechInFormW, "speechInText", args, n);
	XtManageChild(speechInW);
	/* Separator */
	n = 0;
	XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
	XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	XtSetArg(args[n], XmNtopWidget, speechInFormW); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	sep = XmCreateSeparator(panel, "sep", args, n);
	XtManageChild(sep);
    }
    /* Speech-PP label and button */
    if (appres.showSpeechPP) {
	n = 0;
	XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	XtSetArg(args[n], XmNtopWidget, sep); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	speechPPFormW = XmCreateForm(panel, "speechPP", args, n);
	XtManageChild(speechPPFormW);
	if (appres.showLabels) {
	    n = 0;
	    labstr = XmStringCreate("Speech-PP:", XmSTRING_DEFAULT_CHARSET);
	    XtSetArg(args[n], XmNlabelString, labstr); n++;
	    XtSetArg(args[n], XmNalignment, XmALIGNMENT_BEGINNING); n++;
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	    label = XmCreateLabel(speechPPFormW, "label", args, n);
	    XtManageChild(label);
	    XmStringFree(labstr);
	    n = 0;
	    labstr = XmStringCreate("", XmSTRING_DEFAULT_CHARSET);
	    XtSetArg(args[n], XmNlabelString, labstr); n++;
	    XtSetArg(args[n], XmNrecomputeSize, False); n++;
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	    XtSetArg(args[n], XmNtopOffset, 2); n++;
	    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	    XtSetArg(args[n], XmNrightOffset, 20); n++;
	    speechPPStatusW = XmCreatePushButton(speechPPFormW, "status", args, n);
	    XtManageChild(speechPPStatusW);
	    XmStringFree(labstr);
	}
	/* Speech-PP Text */
	n = 0;
	XtSetArg(args[n], XmNrows, appres.rows); n++;
	XtSetArg(args[n], XmNcolumns, appres.columns); n++;
	XtSetArg(args[n], XmNwordWrap, True); n++;
	XtSetArg(args[n], XmNeditMode, XmMULTI_LINE_EDIT); n++;
	XtSetArg(args[n], XmNscrollHorizontal, False); n++;
	XtSetArg(args[n], XmNcursorPositionVisible, False); n++;
	if (appres.showLabels) {
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	    XtSetArg(args[n], XmNtopWidget, label); n++;
	} else {
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
	}
	XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	speechPPW = XmCreateScrolledText(speechPPFormW, "speechPPText", args, n);
	XtManageChild(speechPPW);
    }
    if (appres.showButton) {
	/* Finally, the button */
	if (appres.clickAndHold) {
	    labstr = XmStringCreate("Click and Hold to Talk",
				    XmSTRING_DEFAULT_CHARSET);
	} else {
	    labstr = XmStringCreate("Click to Talk",
				    XmSTRING_DEFAULT_CHARSET);
	}
	n = 0;
	XtSetArg(args[n], XmNlabelString, labstr); n++;
	XtSetArg(args[n], XmNalignment, XmALIGNMENT_CENTER); n++;
	XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	if (appres.showSpeechPP) {
	    XtSetArg(args[n], XmNtopWidget, speechPPFormW); n++;
	} else if (appres.showSpeechIn) {
	    XtSetArg(args[n], XmNtopWidget, speechInFormW); n++;
	} else if (appres.showLabels) {
	    XtSetArg(args[n], XmNtopWidget, sep); n++;
	} else if (appres.showMenus) {
	    XtSetArg(args[n], XmNtopWidget, menubar); n++;
	} else {
	    /* Override! */
	    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
	}
	XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
	XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
	buttonW = XmCreatePushButton(panel, "button", args, n);
	XtManageChild(buttonW);
	XmStringFree(labstr);
	/* Adjust the button translations */
	if (appres.clickAndHold) {
	    XtAddCallback(buttonW, XmNarmCallback, startCB, NULL);
	    XtAddCallback(buttonW, XmNdisarmCallback, stopCB, NULL);
	} else {
	    XtAddCallback(buttonW, XmNactivateCallback, toggleCB, NULL);
	}
    }
    /* Get the font set right for the text items */
    fontCB(speechInW, (XtPointer)(appres.fontsize), NULL);
}

static void
initControlMenu(Widget menubar)
{
    Widget menu, button;
    unsigned char *labstr;
    Arg args[3];
    int n;

    n = 0;
    menu = XmCreatePulldownMenu(menubar, "control", args, n);
    /* Speech-In */
    n = 0;
    labstr = XmStringCreate("Show Speech-In", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNset, appres.showSpeechIn); n++;
    button = XmCreateToggleButton(menu, "speechIn", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNvalueChangedCallback, hideShowCB, (XtPointer)0);
    XmStringFree(labstr);
    /* SpeechPP */
    n = 0;
    labstr = XmStringCreate("Show Speech-PP", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNset, appres.showSpeechPP); n++;
    button = XmCreateToggleButton(menu, "speechpp", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNvalueChangedCallback, hideShowCB, (XtPointer)1);
    XmStringFree(labstr);
    /* SpeechPP Online */
    n = 0;
    labstr = XmStringCreate("Speech-PP Online", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNset, True); n++;
    button = XmCreateToggleButton(menu, "speechppOnline", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNvalueChangedCallback, ppOnlineCB, NULL);
    XmStringFree(labstr);
    /* Quit */
    labstr = XmStringCreate("Quit", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    /* XtSetArg(args[n], XmNmnemonic, 'Q'); n++; */
    button = XmCreatePushButton(menu, "quit", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, quitCB, NULL);
    XmStringFree(labstr);
    /* Add to menubar */
    labstr = XmStringCreate("Control", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    /* XtSetArg(args[n], XmNmnemonic, 'C'); n++; */
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
	button = XmCreatePushButton(menu, "fontsize", args, n);
	XtManageChild(button);
	XtAddCallback(button, XmNactivateCallback, fontCB,
		      (XtPointer)fonts[i].size);
	XmStringFree(labstr);
    }
    /* Add to menubar */
    labstr = XmStringCreate("Font", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    /* XtSetArg(args[n], XmNmnemonic, 'F'); n++; */
    XtSetArg(args[n], XmNsubMenuId, menu); n++;
    button = XmCreateCascadeButton(menubar, "font", args, n);
    XtManageChild(button);
    XmStringFree(labstr);
}

/*	-	-	-	-	-	-	-	-	*/

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
	if (speechInW != NULL) {
	    XtVaSetValues(speechInW, XmNfontList, fl, NULL);
	}
	if (speechPPW != NULL) {
	    XtVaSetValues(speechPPW, XmNfontList, fl, NULL);
	}
    }
}

static void
speechInCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmToggleButtonCallbackStruct *info =
	(XmToggleButtonCallbackStruct*)call_data;

    DEBUG1("set=%d", info->set);
    DEBUG0("done");
}

static void
speechPPCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmToggleButtonCallbackStruct *info =
	(XmToggleButtonCallbackStruct*)call_data;

    DEBUG1("set=%d", info->set);
    DEBUG0("done");
}

static void
ppOnlineCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    static int state = 1;

    DEBUG1("state=%d", state);
    state = !state;
    /* Button says "online", so we invert for "offline" message */
    sendOfflineMsg(!state);
    /* And clear the window */
    XmTextSetString(speechPPW, "");
    DEBUG0("done");
}

static void
hideShowCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmToggleButtonCallbackStruct *info =
	(XmToggleButtonCallbackStruct*)call_data;
    int pp = (int)client_data;
    Widget dw = pp ? speechPPFormW : speechInFormW;

    DEBUG1("set=%d", info->set);
    if (info->set) {
	XtManageChild(dw);
    } else {
	XtUnmanageChild(dw);
    }
    DEBUG0("done");
}

static void
startCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    DEBUG0("starting");
    sendStartMsg();
    DEBUG0("done");
}

static void
stopCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    struct timeval tv;

    tv.tv_sec = appres.stopDelay / 1000000;
    tv.tv_usec = appres.stopDelay % 1000000;
    DEBUG0("delaying...");
    select(0, NULL, NULL, NULL, &tv);
    DEBUG0("stopping");
    sendStopMsg();
    DEBUG0("done");
}

static void
toggleCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    static int talking = 0;
    XmString labstr;

    if (!buttonW) {
	return;
    }
    if (!talking) {
	talking = 1;
	labstr = XmStringCreate("Click to Stop Talking",
				XmSTRING_DEFAULT_CHARSET);
	startCB(w, client_data, call_data);
    } else {
	talking = 0;
	labstr = XmStringCreate("Click to Start Talking",
				XmSTRING_DEFAULT_CHARSET);
	stopCB(w, client_data, call_data);
    }
    XtVaSetValues(buttonW, XmNlabelString, labstr, NULL);
    XmStringFree(labstr);
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
