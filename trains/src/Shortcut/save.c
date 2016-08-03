/*
 * save.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 16 Aug 1996
 * Time-stamp: <96/08/16 11:28:55 ferguson>
 */
#include <stdio.h>
#include <Xm/Xm.h>
#include <Xm/FileSB.h>
#include "save.h"
#include "display.h"
extern Widget toplevel;

/*
 * Functions defined here:
 */
void saveAs(void);
static void createDialog(void);
static void doneCB(Widget w, XtPointer client_data, XtPointer call_data);

/*
 * Data defined here:
 */
static Widget dialogW;

/*	-	-	-	-	-	-	-	-	*/

void
saveAs(void)
{
    XmString dirstr;

    if (dialogW == NULL) {
	createDialog();
    }
    /* Pop it up */
    XtManageChild(dialogW);
}

static void
createDialog(void)
{
    Arg args[3];
    int n;

    n = 0;
    XtSetArg(args[n], XmNdialogStyle, XmDIALOG_FULL_APPLICATION_MODAL); n++;
    XtSetArg(args[n], XmNdefaultButtonType, XmDIALOG_OK_BUTTON); n++;
    XtSetArg(args[n], XmNtitle, "TRAINS Save Shortcuts"); n++;
    dialogW = XmCreateFileSelectionDialog(toplevel, "filesb", args, n);
    XtAddCallback(dialogW, XmNokCallback, doneCB, (XtPointer)1);
    XtAddCallback(dialogW, XmNcancelCallback, doneCB, (XtPointer)0);
    XtUnmanageChild(XmFileSelectionBoxGetChild(dialogW, XmDIALOG_HELP_BUTTON));
}

static void
doneCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    int ok = (int)client_data;
    XmString xstr;
    char *filename;

    if (ok) {
	/* Get the selected filename */
	XtVaGetValues(dialogW, XmNdirSpec, &xstr, NULL);
	XmStringGetLtoR(xstr, XmSTRING_DEFAULT_CHARSET, &filename);
	XtFree(xstr);
	/* Save the messages */
	displaySaveMessages(filename);
	XtFree(filename);
    }
    /* Unmanage child to pop it down */
    XtUnmanageChild(dialogW);
}
