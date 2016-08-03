/*
 * display.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
 * Time-stamp: <Tue Nov 12 11:08:19 EST 1996 ferguson>
 */
#include <stdio.h>
#include <Xm/Xm.h>
#include <Xm/RowColumn.h>
#include <Xm/List.h>
#include "trlib/input.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "display.h"
#include "recv.h"
#include "send.h"
#include "main.h"
#include "rc.h"

/*
 * Functions defined here:
 */
void displayInit(int argc, char **argv);
void displayEventLoop(void);
void displayClose(void);
void displayHideWindow(void);
void displayShowWindow(void);
void displayNewPreset(char *label, char *content);
void displayEndConversation(void);
void displaySetInitialScenario(void);
static void displayInitWidgets(void);
static void randomCB(Widget w, XtPointer client_data, XtPointer call_data);
static void presetCB(Widget w, XtPointer client_data, XtPointer call_data);
static void selectRandomScenario(int n);
static void selectPresetScenario(int n);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);
static void addItemToList(Widget list, int pos, char *label);

/*
 * Data defined here:
 */
static XtAppContext appcon;
static Widget toplevel;
static Widget randomW, presetW;
#define MAX_PRESETS 64
static char *presets[MAX_PRESETS];
static int numPresets = 0;

/* Resources */
typedef struct _AppResources_s {
    char *rcfile;
    int random;
    int preset;
} AppResources;
static AppResources appres;
static XtResource resources[] = {
    { "rcfile", "File", XtRString, sizeof(String),
      XtOffsetOf(AppResources, rcfile), XtRImmediate, "scenario.rc" },
    { "random", "Random", XtRInt, sizeof(int),
      XtOffsetOf(AppResources, random), XtRImmediate, (XtPointer)0 },
    { "preset", "Preset", XtRInt, sizeof(int),
      XtOffsetOf(AppResources, preset), XtRImmediate, (XtPointer)0 },
};
static XrmOptionDescRec options[] = {
    { "-f",		".rcfile",	XrmoptionSepArg },
    { "-random",	".random",	XrmoptionSepArg },
    { "-preset",	".preset",	XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			TRAINS Scenario Chooser",
    "*background:		grey75",
    "*geometry:			-270+0",
    "*XmList.visibleItemCount:	5",
    "*XmList.width:		100",
    "*XmList.listSizePolicy:	constant",
    "*XmList.selectionPolicy:	single_select",
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
    displayInitWidgets();
    XtRealizeWidget(toplevel);
    /* Ready to go */
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
displayNewPreset(char *label, char *content)
{
    DEBUG2("label=%s, content=%s", label, content);
    if (numPresets >= MAX_PRESETS-1) {
	ERROR1("too many presets; max=%d", MAX_PRESETS);
	return;
    }
    /* Note: List items number starting at 1 */
    numPresets += 1;
    addItemToList(presetW, numPresets, label);
    presets[numPresets] = gnewstr(content);
    DEBUG0("done");
}

void
displayEndConversation(void)
{
    int *items, count, current;

    DEBUG0("");
    /* If we've got a preset selected... */
    if (XmListGetSelectedPos(presetW, &items, &count) && count > 0) {
	/* ...Then go to the next one */
	current = items[0];
	if (current == numPresets) {
	    XmListSelectPos(presetW, 1, True);
	} else {
	    XmListSelectPos(presetW, current+1, True);
	}
	/* Free list of selected items */
	free(items);
    }
    DEBUG0("done");
}

void
displaySetInitialScenario(void)
{
    /* Presumably only one these is set... */
    if (appres.random > 0) {
	selectRandomScenario(appres.random);
    }
    if (appres.preset > 0) {
	selectPresetScenario(appres.preset);
    }
}

/*	-	-	-	-	-	-	-	-	*/

static void
displayInitWidgets(void)
{
    Widget rc;
    char str[32];
    Arg args[1];
    int i, n;

    n = 0;
    XtSetArg(args[0], XmNorientation, XmHORIZONTAL); n++;
    rc = XmCreateWorkArea(toplevel, "workarea", args, n);
    randomW = XmCreateScrolledList(rc, "random", NULL, 0);
    XtManageChild(randomW);
    for (i=1; i <= 5; i++) {
	sprintf(str, "Random %d", i);
	addItemToList(randomW, i, str);
    }
    XtAddCallback(randomW, XmNsingleSelectionCallback, randomCB, NULL);
    presetW = XmCreateScrolledList(rc, "preset", NULL, 0);
    XtManageChild(presetW);
    XtAddCallback(presetW, XmNsingleSelectionCallback, presetCB, NULL);
    /* Leave main RC unmanaged until after rcfile is read */
    if (appres.rcfile) {
	readInitFile(appres.rcfile);
    }
    /* Now manage it */
    XtManageChild(rc);
}

static void
randomCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmListCallbackStruct *info = (XmListCallbackStruct*)call_data;

    selectRandomScenario(info->item_position);
}

static void
presetCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmListCallbackStruct *info = (XmListCallbackStruct*)call_data;

    selectPresetScenario(info->item_position);
}

static void
selectRandomScenario(int n)
{
    char content[64];

    DEBUG1("n=%d", n);
    if (n > 0) {
	sprintf(content, "(config :enum %d)", n);
	sendRequestToDM(content);
    }
    /* Make sure item is selected in random list */
    XmListSelectPos(randomW, n, False);
    /* And clear anything selected in preset list */
    XmListDeselectAllItems(presetW);
    DEBUG0("done");
}

static void
selectPresetScenario(int n)
{
    DEBUG1("n=%d", n);
    if (n > 0 && presets[n]) {
	sendRequestToDM(presets[n]);
    }
    /* Make sure item is selected in preset list */
    XmListSelectPos(presetW, n, False);
    /* And clear anything selected in random list */
    XmListDeselectAllItems(randomW);
    DEBUG0("done");
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

static void
addItemToList(Widget list, int pos, char *label)
{
    XmString xmstr;

    xmstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
    XmListAddItem(list, xmstr, pos);
    XmStringFree(xmstr);
}
