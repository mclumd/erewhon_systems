/*
 * dialog.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 31 May 1995
 * Time-stamp: <96/04/17 09:45:49 ferguson>
 */
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Shell.h>
#include <X11/Xaw/Dialog.h>
#include <X11/Xaw/Form.h>
#include <X11/Xaw/Command.h>
#include <X11/Xaw/AsciiText.h>
#include "dialog.h"
#include "displayP.h"

/*
 * Functions defined here:
 */
void displayDialog(DialogType type, char *msg);
static void displayGoalDialog(char *msg);
static void createGoalDialog(void);
static void displayParserDialog(char *msg);
static void createParserDialog(void);
static void doneCB(Widget w, XtPointer client_data, XtPointer call_data);
void hideAllDialogs(void);
void unhideAllDialogs(void);
static void appendTextString(Widget w, char *str);

/*
 * data defined here:
 */
Widget goalShellW, goalDialogW;
int goalPoppedUp;
Position goalShellX = -1, goalShellY = -1;

Widget parserShellW, parserTextW;
int parserPoppedUp;
Position parserShellX = -1, parserShellY = -1;

/*	-	-	-	-	-	-	-	-	*/

void
displayDialog(DialogType type, char *msg)
{
    switch (type) {
      case DIALOG_GOALS:
	displayGoalDialog(msg);
	break;
      case DIALOG_PARSER:
	displayParserDialog(msg);
	break;
    }
}

/*	-	-	-	-	-	-	-	-	*/

static void
displayGoalDialog(char *msg)
{
    if (goalDialogW == NULL) {
	createGoalDialog();
    }
    XtVaSetValues(goalDialogW, XtNlabel, msg, NULL);
    goalPoppedUp = 1;
    XtPopup(goalShellW, XtGrabNone);
}

static void
createGoalDialog(void)
{
    Widget button;

    goalShellW =
	XtVaCreatePopupShell("goalShell", topLevelShellWidgetClass,
			     toplevel,
			     XtNtitle, "Goals for this TRAINS Scenario",
			     XtNallowShellResize, True,
			     NULL);
    goalDialogW =
	XtVaCreateManagedWidget("dialog", dialogWidgetClass, goalShellW,
				NULL);
    XtVaSetValues(XtNameToWidget(goalDialogW, "label"),
		  XtNresize, True, XtNresizable, True, NULL);
    button =
	XtVaCreateManagedWidget("dismiss", commandWidgetClass, goalDialogW,
				XtNlabel, "Dismiss",
				NULL);
    XtAddCallback(button, XtNcallback, doneCB, (XtPointer)goalShellW);
    XtRealizeWidget(goalShellW);
}

/*	-	-	-	-	-	-	-	-	*/

static void
displayParserDialog(char *msg)
{
    if (parserShellW == NULL) {
	createParserDialog();
    }
    /* Hack to detect start of new parse tree (should be a separate message) */
    if (strcasecmp(msg, "SPEECH ACT(S) FOUND") == 0) {
	XtVaSetValues(parserTextW, XtNstring, "", NULL);
    }
    appendTextString(parserTextW, msg);
    appendTextString(parserTextW, "\n");
    parserPoppedUp = 1;
    XtPopup(parserShellW, XtGrabNone);
}

static void
createParserDialog(void)
{
    Widget button, form;

    parserShellW =
	XtVaCreatePopupShell("parserShell", topLevelShellWidgetClass,
			     toplevel,
			     XtNtitle, "TRAINS Parser Output",
			     XtNallowShellResize, True,
			     NULL);
    form = XtVaCreateManagedWidget("form", formWidgetClass, parserShellW,
				   NULL);
    parserTextW =
	XtVaCreateManagedWidget("text", asciiTextWidgetClass, form,
				XtNheight, 300,
				XtNwidth, 600,
				XtNeditType, XawtextAppend,
				XtNscrollHorizontal, XawtextScrollWhenNeeded,
				XtNscrollVertical, XawtextScrollWhenNeeded,
				NULL);
    button =
	XtVaCreateManagedWidget("dismiss", commandWidgetClass, form,
				XtNlabel, "Dismiss",
				XtNfromVert, parserTextW,
				NULL);
    XtAddCallback(button, XtNcallback, doneCB, (XtPointer)parserShellW);
    XtRealizeWidget(parserShellW);
}

/*	-	-	-	-	-	-	-	-	*/

static void
doneCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    Widget shell = (Widget)client_data;

    XtPopdown(shell);
    if (shell == goalShellW) {
	goalPoppedUp = 0;
    } else if (shell == parserShellW) {
	parserPoppedUp = 0;
    }
}

/*	-	-	-	-	-	-	-	-	*/

void
hideAllDialogs(void)
{
    if (goalPoppedUp) {
	XtVaGetValues(goalShellW, XtNx, &goalShellX, XtNy, &goalShellY, NULL);
	XtUnmapWidget(goalShellW);
    }
    if (parserPoppedUp) {
	XtVaGetValues(parserShellW, XtNx, &parserShellX,
		      XtNy, &parserShellY, NULL);
	XtUnmapWidget(parserShellW);
    }
}

void
unhideAllDialogs(void)
{
    if (goalPoppedUp) {
	XtMapWidget(goalShellW);
	if (goalShellX != -1) {
	    XtVaSetValues(goalShellW, XtNx, goalShellX, XtNy, goalShellY,NULL);
	}
	XtVaSetValues(goalDialogW, XtNlabel, "", NULL);
    }
    if (parserPoppedUp) {
	XtMapWidget(parserShellW);
	if (parserShellX != -1) {
	    XtVaSetValues(parserShellW, XtNx, parserShellX,
			  XtNy, parserShellY, NULL);
	}
	XtVaSetValues(parserTextW, XtNlabel, "", NULL);
    }
}

/*	-	-	-	-	-	-	-	-	*/

static void
appendTextString(Widget w, char *str)
{
    XawTextBlock block;
    XawTextPosition pos;

    if ((block.length = strlen(str)) == 0)
	return;
    block.firstPos = 0;
    block.format = FMT8BIT;
    block.ptr = str;
    XtCallActionProc(w,"end-of-file",NULL,NULL,0);
    pos = XawTextGetInsertionPoint(w);
    XawTextReplace(w,pos,pos,&block);
    XtCallActionProc(w,"end-of-file",NULL,NULL,0);
}
