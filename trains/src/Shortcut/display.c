/*
 * display.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 22 Mar 1996
 * Time-stamp: <96/08/19 09:31:23 ferguson>
 */
#include <stdio.h>
#include <Xm/Xm.h>
#include <Xm/RowColumn.h>
#include <Xm/List.h>
#include "trlib/input.h"
#include "util/error.h"
#include "util/debug.h"
#include "util/memory.h"
#include "display.h"
#include "recv.h"
#include "send.h"
#include "main.h"
#include "rc.h"
#include "edit.h"
#include "save.h"
#include "menu_utils.h"

/*
 * Functions defined here:
 */
void displayInit(int argc, char **argv);
void displayEventLoop(void);
void displayClose(void);
void displayHideWindow(void);
void displayShowWindow(void);
void displayNewMessage(char *label, char *content);
void displayReplaceMessage(int num, char *label, char *content);
static void displayInitWidgets(void);
static void selectCB(Widget w, XtPointer client_data, XtPointer call_data);
static void sendCB(Widget w, XtPointer client_data, XtPointer call_data);
static void newCB(Widget w, XtPointer client_data, XtPointer call_data);
static void deleteCB(Widget w, XtPointer client_data, XtPointer call_data);
static void editCB(Widget w, XtPointer client_data, XtPointer call_data);
static void saveCB(Widget w, XtPointer client_data, XtPointer call_data);
static void hideCB(Widget w, XtPointer client_data, XtPointer call_data);
static void quitCB(Widget w, XtPointer client_data, XtPointer call_data);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);
static void addItemToList(Widget list, int pos, char *label);
static void replaceItemInList(Widget list, int pos, char *label);

/*
 * Data defined here:
 */
Widget toplevel;
static XtAppContext appcon;
static Widget listW;
static int selectedItemPos;
#define MAX_MESSAGES 64
static char *labels[MAX_MESSAGES];
static char *messages[MAX_MESSAGES];
static int numMessages = 0;

/* Resources */
typedef struct _AppResources_s {
    char *rcfile;
} AppResources;
static AppResources appres;
static XtResource resources[] = {
    { "rcfile", "File", XtRString, sizeof(String),
      XtOffsetOf(AppResources, rcfile), XtRImmediate, "shortcut.rc" },
};
static XrmOptionDescRec options[] = {
    { "-f",	".rcfile",	XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			TRAINS Shortcuts",
    "*background:		grey75",
    "*geometry:			-270+130",
    "*XmList.width:		100",
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
displayNewMessage(char *label, char *content)
{
    DEBUG2("label=%s, content=%s", label, content);
    if (numMessages >= MAX_MESSAGES) {
	ERROR1("too many messages; max=%d", MAX_MESSAGES);
	return;
    }
    labels[numMessages] = gnewstr(label);
    messages[numMessages] = gnewstr(content);
    numMessages += 1;
    addItemToList(listW, numMessages, label);
    DEBUG0("done");
}

void
displayReplaceMessage(int num, char *label, char *content)
{
    DEBUG3("num=%d, label=%s, content=%s", num, label, content);
    if (num < 0 || num >= MAX_MESSAGES) {
	ERROR1("bad index to replace: %d", num);
	return;
    }    
    XtFree(labels[num]);
    labels[num] = gnewstr(label);
    XtFree(messages[num]);
    messages[num] = gnewstr(content);
    replaceItemInList(listW, num+1, label);
    DEBUG0("done");
}

void
displaySaveMessages(char *filename)
{
    FILE *fp;
    int i;

    if ((fp = fopen(filename, "w")) == NULL) {
	SYSERR1("couldn't write %s", filename);
	return;
    }
    for (i=0; i < numMessages; i++) {
	/* Note: This doesn't escape quotes in labels! */
	fprintf(fp, "(request :content (define :label \"%s\" :content %s))\n",
		labels[i], messages[i]);
    }
    fclose(fp);
}

/*	-	-	-	-	-	-	-	-	*/

static MenuItemInfo items[] = {
    { MI_PUSHBUTTON, "new",	"New",		'N', newCB },
    { MI_PUSHBUTTON, "delete",	"Delete",	'D', deleteCB },
    { MI_PUSHBUTTON, "edit",	"Edit",		'E', editCB },
    { MI_PUSHBUTTON, "saveAs",	"Save As",	'S', saveCB },
    { MI_SEPARATOR },
    { MI_PUSHBUTTON, "hide",	"Hide",		'H', hideCB },
    { MI_PUSHBUTTON, "quit",	"Quit",		'Q', quitCB },
    { MI_END }
};

static void
displayInitWidgets(void)
{
    Widget rc, menubarW;
    Arg args[3];
    int n;

    /* Main window */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    rc = XmCreateWorkArea(toplevel, "main", args, n);
    /* Menu bar */
    n = 0;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    XtSetArg(args[n], XmNmarginWidth, 0); n++;
    XtSetArg(args[n], XmNshadowThickness, 0); n++;
    menubarW = XmCreateMenuBar(rc, "menubar", args, n);
    XtManageChild(menubarW);
    (void)createMenu(menubarW, "file", "File", 'F', items, NULL);
    /* List */
    n = 0;
    XtSetArg(args[n], XmNvisibleItemCount, 5); n++;
    XtSetArg(args[n], XmNlistSizePolicy, XmCONSTANT); n++;
    XtSetArg(args[n], XmNselectionPolicy, XmSINGLE_SELECT); n++;
    listW = XmCreateScrolledList(rc, "list", args, n);
    XtManageChild(listW);
    XtAddCallback(listW, XmNsingleSelectionCallback, selectCB, NULL);
    XtAddCallback(listW, XmNdefaultActionCallback, sendCB, NULL);
    /* Read the startup file (now that the list is ready) */
    if (appres.rcfile) {
	readInitFile(appres.rcfile);
    }
    /* Mange main RC after list is set */
    XtManageChild(rc);
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * These are called from the message list
 */

static void
selectCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmListCallbackStruct *info = (XmListCallbackStruct*)call_data;

    selectedItemPos = info->item_position;
}

static void
sendCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmListCallbackStruct *info = (XmListCallbackStruct*)call_data;

    selectCB(w, client_data, call_data);
    sendMsg(messages[info->item_position-1]);
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * These are called from the File menu.
 */

static void
newCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    editMessage(-1, NULL, NULL);
}

static void
deleteCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    DEBUG1("selectedItemPos=%d", selectedItemPos);
    if (selectedItemPos > 0) {
	XmListDeletePos(listW, selectedItemPos);
	XmListDeselectAllItems(listW);
	selectedItemPos = -1;
    } else {
	XBell(XtDisplay(toplevel), 0);
    }
    DEBUG0("done");
}

static void
editCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    DEBUG1("selectedItemPos=%d", selectedItemPos);
    if (selectedItemPos > 0) {
	editMessage(selectedItemPos-1,
		    labels[selectedItemPos-1], messages[selectedItemPos-1]);
    } else {
	XBell(XtDisplay(toplevel), 0);
    }
    DEBUG0("done");
}

static void
saveCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    saveAs();
}

static void
hideCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    displayHideWindow();
}

static void
quitCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    programExit(0);
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

static void
replaceItemInList(Widget list, int pos, char *label)
{
    XmString xmstr;

    xmstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
    XmListReplaceItemsPos(list, &xmstr, 1, pos);
    XmStringFree(xmstr);
}
