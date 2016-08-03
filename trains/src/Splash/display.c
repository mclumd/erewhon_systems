/*
 * display.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Feb 1996
 * Time-stamp: <Thu Nov 14 17:03:59 EST 1996 ferguson>
 */
#include <stdio.h>
#include <pwd.h>
#include <Xm/Xm.h>
#include <Xm/Form.h>
#include <Xm/Frame.h>
#include <Xm/RowColumn.h>
#include <Xm/Label.h>
#include <Xm/TextF.h>
#include <Xm/ToggleB.h>
#include <Xm/PushB.h>
#include "trlib/input.h"
#include "util/error.h"
#include "util/debug.h"
#include "display.h"
#include "conv.h"
#include "recv.h"
#include "main.h"
#include "xpm.h"
#include "logdir.h"
#include "appres.h"

#ifndef TITLE
# define TITLE "The TRAINS System"
#endif

/*
 * Functions defined here:
 */
void displayInit(int argc, char **argv);
void displayEventLoop(void);
void displayExit(void);
void displayHideWindow(void);
void displayShowWindow(void);
static void displayInitActions(void);
static void displayInitWidgets(void);
static void displayInitPixmap(Widget form);
static void sexCB(Widget w, XtPointer client_data, XtPointer call_data);
static void helpCB(Widget w, XtPointer client_data, XtPointer call_data);
static void practiceCB(Widget w, XtPointer client_data, XtPointer call_data);
static void startCB(Widget w, XtPointer client_data, XtPointer call_data);
static void quitCB(Widget w, XtPointer client_data, XtPointer call_data);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);
static void getUsername(Widget w, int offset, XrmValue *value);

/*
 * Data defined here:
 */
XtAppContext appcon;
Widget toplevel;
static Widget mainW;
static Widget nameW, langW, maleW, femaleW, introW, goalsW, scoringW;

/* Resources */
AppResources appres;

static XtResource resources[] = {
    { "pixmap", "Pixmap", XtRString, sizeof(String),
      XtOffsetOf(AppResources, pixmap), XtRImmediate, "splash.xpm" },
    { "logdir", "Logdir", XtRString, sizeof(String),
      XtOffsetOf(AppResources, logdir), XtRImmediate, NULL },
    { "username", "Username", XtRString, sizeof(String),
      XtOffsetOf(AppResources, username), XtRCallProc, getUsername },
    { "userlang", "Userlang", XtRString, sizeof(String),
      XtOffsetOf(AppResources, userlang), XtRImmediate, "US English" },
    { "usersex", "Usersex", XtRString, sizeof(String),
      XtOffsetOf(AppResources, usersex), XtRImmediate, "male" },
    { "intro", "Intro", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources, intro), XtRImmediate, (XtPointer)False },
    { "goals", "Goals", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources, goals), XtRImmediate, (XtPointer)True },
    { "scoring", "Scoring", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources, scoring), XtRImmediate, (XtPointer)True },
    { "asksave", "Asksave", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources, asksave), XtRImmediate, (XtPointer)True },
};
static XrmOptionDescRec options[] = {
    { "-pixmap",	".pixmap",		XrmoptionSepArg },
    { "-logdir",	".logdir",		XrmoptionSepArg },
    { "-name",		".username",		XrmoptionSepArg },
    { "-lang",		".userlang",		XrmoptionSepArg },
    { "-sex",		".usersex",		XrmoptionSepArg },
    { "-intro",		".intro",		XrmoptionSepArg },
    { "-goals",		".goals",		XrmoptionSepArg },
    { "-scoring",	".scoring",		XrmoptionSepArg },
    { "-asksave",	".asksave",		XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			" TITLE,
    "*geometry:			+200+100",
    "*background:		grey75",
    "*XmTextField.background:	light blue",
    "*FontList:			*helvetica-bold-r-*-*-10*",
    "*XmTextField.FontList:	*helvetica-medium-r-*-*-10*",
    "*main.width:		511",
    "*main.height:		485",
    "*user.topOffset:		355",
    "*user.leftOffset:		25",
    "*XmPushButton.FontList:	*helvetica-bold-r-*-*-14*",
    "*XmPushButton.bottomOffset:	10",
    "*main.XmPushButton.height:	40",
    "*main.XmPushButton.width:		64",
    "*Help.leftOffset:		10",
    "*Practice.leftOffset:	140",
    "*Start.leftOffset:		290",
    "*Quit.rightOffset:		10",
    /* Save panel */
    "*save*FontList:		*helvetica-bold-r-*-*-12*",
    "*save*XmTextField.FontList:*helvetica-medium-r-*-*-12*",
    "*save*XmPushButton.FontList:*helvetica-bold-r-*-*-12*",
    /* Email panel */
    "*email*FontList:			*helvetica-bold-r-*-*-12*",
    "*email*XmTextField.FontList:	*helvetica-medium-r-*-*-12*",
    "*email*XmPushButton.FontList:*helvetica-bold-r-*-*-12*",
    NULL
};

/*	-	-	-	-	-	-	-	-	*/

void
displayInit(int argc, char **argv)
{
    DEBUG0("initializing display");
    /* Initialize display */
    toplevel = XtVaAppInitialize(&appcon, "TRAINS",
				 options, XtNumber(options),
				 &argc, argv, fallbackResources,
				 NULL);
    /* Get non-widget resources */
    XtGetApplicationResources(toplevel, (XtPointer)&appres,
			      resources, XtNumber(resources), NULL, 0);
    /* Setup widgets */
    displayInitWidgets();
    /* And realize them */
    XtRealizeWidget(toplevel);
    /* Setup the main pixmap once we have a window (after realizing) */
    displayInitPixmap(mainW);
    /* Finally, if logdir was set, use it to override trains_base */
    if (appres.logdir) {
	setLogDirectory(appres.logdir);
    }
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
displayExit(void)
{
    XtDestroyApplicationContext(appcon);
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
    XtSetKeyboardFocus(toplevel, nameW);
}

/*	-	-	-	-	-	-	-	-	*/

static void
displayInitWidgets(void)
{
    Widget frame, userform, subform, radio, rc, label, button;
    Arg args[6];
    XmString labstr;
    int n;

    n = 0;
    mainW = XmCreateForm(toplevel, "main", args, n);
    /* User info area */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    frame = XmCreateFrame(mainW, "user", args, n);
    XtManageChild(frame);
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    XtSetArg(args[n], XmNpacking, XmPACK_COLUMN); n++;
    XtSetArg(args[n], XmNnumColumns, 2); n++;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    userform = XmCreateWorkArea(frame, "rc", args, n);
    /* User name */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    subform = XmCreateForm(userform, "subform", args, n);
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNalignment, XmALIGNMENT_BEGINNING); n++;
    label = XmCreateLabel(subform, "Name:", args, n);
    XtManageChild(label);
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNleftWidget, label); n++;
    XtSetArg(args[n], XmNvalue, appres.username); n++;
    nameW = XmCreateTextField(subform, "name", args, n);
    XtManageChild(nameW);
    XtManageChild(subform);
    /* User lang */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    subform = XmCreateForm(userform, "subform", args, n);
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNalignment, XmALIGNMENT_BEGINNING); n++;
    label = XmCreateLabel(subform, "Language:", args, n);
    XtManageChild(label);
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNleftWidget, label); n++;
    XtSetArg(args[n], XmNvalue, appres.userlang); n++;
    langW = XmCreateTextField(subform, "lang", args, n);
    XtManageChild(langW);
    XtManageChild(subform);
    /* User sex */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    rc = XmCreateWorkArea(userform, "sex", args, n);
    n = 0;
    labstr = XmStringCreate("Voice:", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    label = XmCreateLabel(rc, "label", args, n);
    XtManageChild(label);
    XmStringFree(labstr);
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    radio = XmCreateRadioBox(rc, "radio", args, n);
    n = 0;
    XtSetArg(args[n], XmNset, *(appres.usersex)=='m' ? True: False); n++;
    maleW = XmCreateToggleButton(radio, "Male", args, n);
    XtManageChild(maleW);
    XtAddCallback(maleW, XmNvalueChangedCallback, sexCB, NULL);
    n = 0;
    XtSetArg(args[n], XmNset, *(appres.usersex)=='f' ? True: False); n++;
    femaleW = XmCreateToggleButton(radio, "Female", args, n);
    XtAddCallback(femaleW, XmNvalueChangedCallback, sexCB, NULL);
    XtManageChild(femaleW);
    XtManageChild(radio);
    XtManageChild(rc);
    /* Other user prefs */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    rc = XmCreateWorkArea(userform, "other", args, n);
    n = 0;
    labstr = XmStringCreate("Options:", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    label = XmCreateLabel(rc, "label", args, n);
    XtManageChild(label);
    XmStringFree(labstr);
    n = 0;
    XtSetArg(args[n], XmNset, appres.intro); n++;
    introW = XmCreateToggleButton(rc, "Intro", args, n);
    XtManageChild(introW);
    n = 0;
    XtSetArg(args[n], XmNset, appres.goals); n++;
    goalsW = XmCreateToggleButton(rc, "Goals", args, n);
    XtManageChild(goalsW);
    n = 0;
    XtSetArg(args[n], XmNset, appres.scoring); n++;
    scoringW = XmCreateToggleButton(rc, "Scoring", args, n);
    XtManageChild(scoringW);
    XtManageChild(rc);
    /* End of user info panel */
    XtManageChild(userform);
    /* Buttons */
    n = 0;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    button = XmCreatePushButton(mainW, "Help", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, helpCB, NULL);
    n = 0;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    button = XmCreatePushButton(mainW, "Practice", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, practiceCB, NULL);
    n = 0;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    button = XmCreatePushButton(mainW, "Start", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, startCB, NULL);
    n = 0;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
    button = XmCreatePushButton(mainW, "Quit", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, quitCB, NULL);
    /* End of main form */
    XtManageChild(mainW);
}

static void
displayInitPixmap(Widget w)
{
    Pixmap pix;
    Colormap cmap = (Colormap)0;

    pix = readXpmFile(XtDisplay(toplevel), appres.pixmap, &cmap);
    DEBUG2("pix=0x%lx, cmap=0x%lx", pix, cmap);
    if (cmap != (Colormap)0) {
	XtVaSetValues(toplevel, XtNcolormap, cmap, NULL);
    }
    if (pix != (Pixmap)0) {
	XtVaSetValues(w, XtNbackgroundPixmap, pix, NULL);
    }
}

/*	-	-	-	-	-	-	-	-	*/

static void
sexCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    if (XmToggleButtonGetState(w)) {
	printf("(request :receiver pm :content (restart speech-in :argv (tspeechin -sex %s)))\n", (w == maleW) ? "m" : "f");
	fflush(stdout);
    }
}

static void
helpCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    char cmd[256];

    sprintf(cmd, "%s/bin/tintro", trains_base);
    system(cmd);
}

static void
practiceCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    sendPracticeMsg();
}

static void
startCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    char *name, *lang;
    Boolean male, intro, goals, scoring;

    name = XmTextFieldGetString(nameW);
    lang = XmTextFieldGetString(langW);
    male = XmToggleButtonGetState(maleW);
    intro = XmToggleButtonGetState(introW);
    goals = XmToggleButtonGetState(goalsW);
    scoring = XmToggleButtonGetState(scoringW);
    convStart(name, lang, (male ? "male" : "female"),
	      (intro ? "t" : "nil"), (goals ? ":rootabega" : "nil"),
	      (scoring ? "t" : "nil"));
}

static void
quitCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    sendIMExitMsg();
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
/* This is used to initialize a resource from the environment */

static void
getUsername(Widget w, int offset, XrmValue *value)
{
    struct passwd *p;

    value->size = sizeof(String);
    if ((p = getpwuid(getuid())) != NULL) {
	if (p->pw_gecos != NULL) {
	    value->addr = p->pw_gecos;
	} else if (p->pw_name != NULL) {
	    value->addr = p->pw_name;
	} else {
	    value->addr = "";
	}
    } else {
	value->addr = "";
    }
}

